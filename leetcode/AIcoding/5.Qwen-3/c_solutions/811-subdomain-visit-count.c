#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char *domain;
    int count;
} DomainCount;

typedef struct {
    DomainCount *data;
    int size;
    int capacity;
} HashTable;

unsigned long hash(const char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

void initHashTable(HashTable *table, int initialCapacity) {
    table->size = 0;
    table->capacity = initialCapacity;
    table->data = (DomainCount *)malloc(initialCapacity * sizeof(DomainCount));
}

void freeHashTable(HashTable *table) {
    for (int i = 0; i < table->size; i++) {
        free(table->data[i].domain);
    }
    free(table->data);
}

void resizeHashTable(HashTable *table) {
    int newCapacity = table->capacity * 2;
    DomainCount *newData = (DomainCount *)malloc(newCapacity * sizeof(DomainCount));
    for (int i = 0; i < table->size; i++) {
        newData[i] = table->data[i];
    }
    free(table->data);
    table->data = newData;
    table->capacity = newCapacity;
}

void addDomainCount(HashTable *table, const char *domain, int count) {
    unsigned long h = hash(domain);
    int index = h % table->capacity;
    while (table->data[index].domain != NULL) {
        if (strcmp(table->data[index].domain, domain) == 0) {
            table->data[index].count += count;
            return;
        }
        index = (index + 1) % table->capacity;
    }
    table->data[index].domain = strdup(domain);
    table->data[index].count = count;
    table->size++;
    if (table->size >= table->capacity * 0.75) {
        resizeHashTable(table);
    }
}

char **subdomainVisits(char **cpdomains, int cpdomainsSize, int *returnSize) {
    HashTable table;
    initHashTable(&table, 100);
    for (int i = 0; i < cpdomainsSize; i++) {
        char *token = strtok(cpdomains[i], " ");
        int count = atoi(token);
        token = strtok(NULL, " ");
        char *current = strdup(token);
        char *saveptr;
        while (current) {
            char *subdomain = strtok_r(current, ".", &saveptr);
            if (subdomain) {
                char *fullSubdomain = strdup(subdomain);
                char *temp = strtok_r(NULL, ".", &saveptr);
                while (temp) {
                    fullSubdomain = realloc(fullSubdomain, strlen(fullSubdomain) + strlen(temp) + 2);
                    strcat(fullSubdomain, ".");
                    strcat(fullSubdomain, temp);
                    temp = strtok_r(NULL, ".", &saveptr);
                }
                addDomainCount(&table, fullSubdomain, count);
                free(fullSubdomain);
            }
            current = strtok_r(NULL, ".", &saveptr);
        }
        free(current);
    }

    *returnSize = table.size;
    char **result = (char **)malloc(table.size * sizeof(char *));
    for (int i = 0; i < table.size; i++) {
        result[i] = (char *)malloc(100 * sizeof(char));
        sprintf(result[i], "%d %s", table.data[i].count, table.data[i].domain);
    }

    freeHashTable(&table);
    return result;
}
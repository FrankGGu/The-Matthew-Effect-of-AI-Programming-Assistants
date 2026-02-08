#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    char *domain;
    int count;
    struct Node *next;
};

struct HashMap {
    struct Node **table;
    int size;
};

unsigned int hash(const char *str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

struct HashMap *createHashMap(int size) {
    struct HashMap *map = malloc(sizeof(struct HashMap));
    map->table = malloc(sizeof(struct Node *) * size);
    for (int i = 0; i < size; i++) {
        map->table[i] = NULL;
    }
    map->size = size;
    return map;
}

void insert(struct HashMap *map, const char *domain, int count) {
    unsigned int index = hash(domain) % map->size;
    struct Node *node = map->table[index];
    while (node) {
        if (strcmp(node->domain, domain) == 0) {
            node->count += count;
            return;
        }
        node = node->next;
    }
    node = malloc(sizeof(struct Node));
    node->domain = strdup(domain);
    node->count = count;
    node->next = map->table[index];
    map->table[index] = node;
}

void freeHashMap(struct HashMap *map) {
    for (int i = 0; i < map->size; i++) {
        struct Node *node = map->table[i];
        while (node) {
            struct Node *temp = node;
            node = node->next;
            free(temp->domain);
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

char **subdomainVisits(char **cpdomains, int cpdomainsSize, int *returnSize) {
    struct HashMap *map = createHashMap(100);
    for (int i = 0; i < cpdomainsSize; i++) {
        int count;
        char *domain = strdup(cpdomains[i]);
        char *p = strchr(domain, ' ');
        *p = '\0';
        count = atoi(domain);
        insert(map, p + 1, count);

        char *subdomain = p + 1;
        while ((subdomain = strchr(subdomain, '.'))) {
            subdomain++;
            insert(map, subdomain, count);
        }
        free(domain);
    }

    char **result = malloc(sizeof(char *) * map->size);
    int idx = 0;
    for (int i = 0; i < map->size; i++) {
        struct Node *node = map->table[i];
        while (node) {
            char *entry = malloc(strlen(node->domain) + 20);
            sprintf(entry, "%d %s", node->count, node->domain);
            result[idx++] = entry;
            node = node->next;
        }
    }
    freeHashMap(map);
    *returnSize = idx;
    return result;
}
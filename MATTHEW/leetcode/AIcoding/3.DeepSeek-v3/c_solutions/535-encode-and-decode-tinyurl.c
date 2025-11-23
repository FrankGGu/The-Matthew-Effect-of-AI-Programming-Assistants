#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    char* key;
    char* value;
} HashItem;

typedef struct {
    HashItem** items;
    int size;
    int count;
} HashTable;

HashTable* createTable(int size) {
    HashTable* table = malloc(sizeof(HashTable));
    table->size = size;
    table->count = 0;
    table->items = calloc(size, sizeof(HashItem*));
    return table;
}

unsigned int hash(const char* str, int size) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash % size;
}

void insert(HashTable* table, char* key, char* value) {
    unsigned int index = hash(key, table->size);
    while (table->items[index] != NULL) {
        index = (index + 1) % table->size;
    }
    HashItem* item = malloc(sizeof(HashItem));
    item->key = malloc(strlen(key) + 1);
    strcpy(item->key, key);
    item->value = malloc(strlen(value) + 1);
    strcpy(item->value, value);
    table->items[index] = item;
    table->count++;
}

char* search(HashTable* table, char* key) {
    unsigned int index = hash(key, table->size);
    while (table->items[index] != NULL) {
        if (strcmp(table->items[index]->key, key) == 0) {
            return table->items[index]->value;
        }
        index = (index + 1) % table->size;
    }
    return NULL;
}

HashTable* urlMap = NULL;
int counter = 0;

char* encode(char* longUrl) {
    if (urlMap == NULL) {
        urlMap = createTable(10000);
    }

    char shortUrl[20];
    sprintf(shortUrl, "http://tinyurl.com/%d", counter++);

    char* key = malloc(strlen(shortUrl) + 1);
    strcpy(key, shortUrl);

    insert(urlMap, key, longUrl);

    return key;
}

char* decode(char* shortUrl) {
    return search(urlMap, shortUrl);
}
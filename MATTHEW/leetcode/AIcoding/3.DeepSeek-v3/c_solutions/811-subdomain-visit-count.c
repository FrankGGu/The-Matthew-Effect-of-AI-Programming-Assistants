typedef struct {
    char* key;
    int count;
} DomainCount;

typedef struct {
    DomainCount* entries;
    int capacity;
    int size;
} HashMap;

unsigned int hash(const char* str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;
    return hash;
}

void initHashMap(HashMap* map, int capacity) {
    map->capacity = capacity;
    map->size = 0;
    map->entries = (DomainCount*)calloc(capacity, sizeof(DomainCount));
}

void put(HashMap* map, const char* key, int count) {
    unsigned int index = hash(key) % map->capacity;
    while (map->entries[index].key != NULL && strcmp(map->entries[index].key, key) != 0) {
        index = (index + 1) % map->capacity;
    }
    if (map->entries[index].key == NULL) {
        map->entries[index].key = strdup(key);
        map->entries[index].count = count;
        map->size++;
    } else {
        map->entries[index].count += count;
    }
}

int get(HashMap* map, const char* key) {
    unsigned int index = hash(key) % map->capacity;
    while (map->entries[index].key != NULL) {
        if (strcmp(map->entries[index].key, key) == 0) {
            return map->entries[index].count;
        }
        index = (index + 1) % map->capacity;
    }
    return 0;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->capacity; i++) {
        if (map->entries[i].key != NULL) {
            free(map->entries[i].key);
        }
    }
    free(map->entries);
}

char ** subdomainVisits(char **cpdomains, int cpdomainsSize, int* returnSize) {
    HashMap map;
    initHashMap(&map, 10000);

    for (int i = 0; i < cpdomainsSize; i++) {
        char* cpdomain = cpdomains[i];
        int count = atoi(strtok(cpdomain, " "));
        char* domain = strtok(NULL, " ");

        put(&map, domain, count);

        char* dot = strchr(domain, '.');
        while (dot != NULL) {
            char* subdomain = dot + 1;
            put(&map, subdomain, count);
            dot = strchr(subdomain, '.');
        }
    }

    char** result = (char**)malloc(map.size * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < map.capacity; i++) {
        if (map.entries[i].key != NULL) {
            char* entry = (char*)malloc(100 * sizeof(char));
            sprintf(entry, "%d %s", map.entries[i].count, map.entries[i].key);
            result[(*returnSize)++] = entry;
        }
    }

    freeHashMap(&map);
    return result;
}
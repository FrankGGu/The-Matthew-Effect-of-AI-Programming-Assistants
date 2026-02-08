typedef struct LRUCache {
    int capacity;
    struct ListNode *head;
    struct ListNode *tail;
    struct HashMap *map;
} LRUCache;

struct ListNode {
    int key;
    int value;
    struct ListNode *prev;
    struct ListNode *next;
};

struct HashMap {
    struct ListNode **table;
    int size;
};

struct ListNode* createNode(int key, int value) {
    struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));
    newNode->key = key;
    newNode->value = value;
    newNode->prev = NULL;
    newNode->next = NULL;
    return newNode;
}

struct HashMap* createHashMap(int size) {
    struct HashMap* map = (struct HashMap*)malloc(sizeof(struct HashMap));
    map->table = (struct ListNode**)calloc(size, sizeof(struct ListNode*));
    map->size = size;
    return map;
}

unsigned int hash(int key, int size) {
    return key % size;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->head = createNode(0, 0);
    cache->tail = createNode(0, 0);
    cache->head->next = cache->tail;
    cache->tail->prev = cache->head;
    cache->map = createHashMap(capacity);
    return cache;
}

void removeNode(struct ListNode* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
}

void addToHead(LRUCache* cache, struct ListNode* node) {
    node->next = cache->head->next;
    node->prev = cache->head;
    cache->head->next->prev = node;
    cache->head->next = node;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    struct ListNode* node = obj->map->table[hash(key, obj->map->size)];
    if (node) {
        node->value = value;
        removeNode(node);
        addToHead(obj, node);
    } else {
        if (obj->map->size >= obj->capacity) {
            struct ListNode* tailNode = obj->tail->prev;
            removeNode(tailNode);
            obj->map->table[hash(tailNode->key, obj->map->size)] = NULL;
            free(tailNode);
        }
        struct ListNode* newNode = createNode(key, value);
        addToHead(obj, newNode);
        obj->map->table[hash(key, obj->map->size)] = newNode;
    }
}

int lRUCacheGet(LRUCache* obj, int key) {
    struct ListNode* node = obj->map->table[hash(key, obj->map->size)];
    if (!node) return -1;
    removeNode(node);
    addToHead(obj, node);
    return node->value;
}

void lRUCacheFree(LRUCache* obj) {
    struct ListNode* curr = obj->head;
    while (curr) {
        struct ListNode* next = curr->next;
        free(curr);
        curr = next;
    }
    free(obj->map->table);
    free(obj->map);
    free(obj);
}
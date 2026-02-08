typedef struct ListNode {
    int key;
    int value;
    struct ListNode *prev;
    struct ListNode *next;
} ListNode;

typedef struct {
    int capacity;
    ListNode *head;
    ListNode *tail;
    int size;
    struct hashmap {
        ListNode **table;
        int capacity;
    } map;
} LRUCache;

ListNode* createNode(int key, int value) {
    ListNode* node = (ListNode*)malloc(sizeof(ListNode));
    node->key = key;
    node->value = value;
    node->prev = NULL;
    node->next = NULL;
    return node;
}

void removeNode(LRUCache* obj, ListNode* node) {
    if (node->prev) node->prev->next = node->next;
    if (node->next) node->next->prev = node->prev;
    if (node == obj->head) obj->head = node->next;
    if (node == obj->tail) obj->tail = node->prev;
    obj->size--;
}

void addToHead(LRUCache* obj, ListNode* node) {
    node->next = obj->head;
    node->prev = NULL;
    if (obj->head) obj->head->prev = node;
    obj->head = node;
    if (!obj->tail) obj->tail = node;
    obj->size++;
}

void moveToHead(LRUCache* obj, ListNode* node) {
    removeNode(obj, node);
    addToHead(obj, node);
}

unsigned int hash(int key) {
    return key % 1000;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* obj = (LRUCache*)malloc(sizeof(LRUCache));
    obj->capacity = capacity;
    obj->size = 0;
    obj->head = NULL;
    obj->tail = NULL;
    obj->map.capacity = 1000;
    obj->map.table = (ListNode**)calloc(obj->map.capacity, sizeof(ListNode*));
    return obj;
}

int lRUCacheGet(LRUCache* obj, int key) {
    unsigned int idx = hash(key);
    ListNode* node = obj->map.table[idx];
    while (node) {
        if (node->key == key) {
            moveToHead(obj, node);
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    unsigned int idx = hash(key);
    ListNode* node = obj->map.table[idx];
    while (node) {
        if (node->key == key) {
            node->value = value;
            moveToHead(obj, node);
            return;
        }
        node = node->next;
    }
    if (obj->size >= obj->capacity) {
        ListNode* tailNode = obj->tail;
        removeNode(obj, tailNode);
        obj->map.table[hash(tailNode->key)] = NULL;
        free(tailNode);
    }
    ListNode* newNode = createNode(key, value);
    newNode->next = obj->map.table[idx];
    obj->map.table[idx] = newNode;
    addToHead(obj, newNode);
}

void lRUCacheFree(LRUCache* obj) {
    ListNode* node = obj->head;
    while (node) {
        ListNode* temp = node;
        node = node->next;
        free(temp);
    }
    free(obj->map.table);
    free(obj);
}
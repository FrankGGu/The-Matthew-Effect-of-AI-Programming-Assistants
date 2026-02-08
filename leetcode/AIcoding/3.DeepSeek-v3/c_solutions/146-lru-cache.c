typedef struct Node {
    int key;
    int value;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    int capacity;
    int size;
    Node* head;
    Node* tail;
    Node** hash;
} LRUCache;

Node* createNode(int key, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->prev = NULL;
    newNode->next = NULL;
    return newNode;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->head = createNode(-1, -1);
    cache->tail = createNode(-1, -1);
    cache->head->next = cache->tail;
    cache->tail->prev = cache->head;
    cache->hash = (Node**)calloc(10001, sizeof(Node*));
    return cache;
}

void removeNode(LRUCache* obj, Node* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
}

void addToHead(LRUCache* obj, Node* node) {
    node->next = obj->head->next;
    node->prev = obj->head;
    obj->head->next->prev = node;
    obj->head->next = node;
}

int lRUCacheGet(LRUCache* obj, int key) {
    if (obj->hash[key] == NULL) {
        return -1;
    }
    Node* node = obj->hash[key];
    removeNode(obj, node);
    addToHead(obj, node);
    return node->value;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    if (obj->hash[key] != NULL) {
        Node* node = obj->hash[key];
        node->value = value;
        removeNode(obj, node);
        addToHead(obj, node);
    } else {
        Node* newNode = createNode(key, value);
        obj->hash[key] = newNode;
        if (obj->size < obj->capacity) {
            obj->size++;
            addToHead(obj, newNode);
        } else {
            Node* tailPrev = obj->tail->prev;
            obj->hash[tailPrev->key] = NULL;
            removeNode(obj, tailPrev);
            free(tailPrev);
            addToHead(obj, newNode);
        }
    }
}

void lRUCacheFree(LRUCache* obj) {
    Node* current = obj->head;
    while (current != NULL) {
        Node* temp = current;
        current = current->next;
        free(temp);
    }
    free(obj->hash);
    free(obj);
}
#include <stdlib.h>
#include <uthash.h>

typedef struct Node {
    int key;
    int value;
    struct Node *prev;
    struct Node *next;
    UT_hash_handle hh;
} Node;

typedef struct {
    int capacity;
    int size;
    Node *head;
    Node *tail;
    Node *map;
} LRUCache;

void removeNode(Node *node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
}

void addNode(LRUCache *obj, Node *node) {
    node->next = obj->head->next;
    node->prev = obj->head;
    obj->head->next->prev = node;
    obj->head->next = node;
}

void moveToHead(LRUCache *obj, Node *node) {
    removeNode(node);
    addNode(obj, node);
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache *cache = (LRUCache *)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->map = NULL;

    cache->head = (Node *)malloc(sizeof(Node));
    cache->tail = (Node *)malloc(sizeof(Node));

    cache->head->prev = NULL;
    cache->head->next = cache->tail;
    cache->tail->prev = cache->head;
    cache->tail->next = NULL;

    return cache;
}

int lRUCacheGet(LRUCache* obj, int key) {
    Node *found_node;
    HASH_FIND_INT(obj->map, &key, found_node);

    if (found_node == NULL) {
        return -1;
    }

    moveToHead(obj, found_node);
    return found_node->value;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    Node *found_node;
    HASH_FIND_INT(obj->map, &key, found_node);

    if (found_node != NULL) {
        found_node->value = value;
        moveToHead(obj, found_node);
    } else {
        Node *new_node = (Node *)malloc(sizeof(Node));
        new_node->key = key;
        new_node->value = value;

        HASH_ADD_INT(obj->map, key, new_node);

        addNode(obj, new_node);
        obj->size++;

        if (obj->size > obj->capacity) {
            Node *lru_node = obj->tail->prev;

            HASH_DEL(obj->map, lru_node);

            removeNode(lru_node);

            free(lru_node);
            obj->size--;
        }
    }
}

void lRUCacheFree(LRUCache* obj) {
    Node *current_node, *tmp;
    HASH_ITER(hh, obj->map, current_node, tmp) {
        HASH_DEL(obj->map, current_node);
        free(current_node);
    }
    free(obj->head);
    free(obj->tail);
    free(obj);
}
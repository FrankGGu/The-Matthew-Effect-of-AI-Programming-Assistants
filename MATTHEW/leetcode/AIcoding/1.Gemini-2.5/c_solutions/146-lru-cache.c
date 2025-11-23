#include <stdlib.h>

typedef struct Node {
    int key;
    int val;
    struct Node *prev;
    struct Node *next;
} Node;

typedef struct {
    int capacity;
    int size;
    Node *head;
    Node *tail;
    Node **map;
    int map_size;
} LRUCache;

static void _remove_node(Node* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
}

static void _add_to_front(LRUCache* obj, Node* node) {
    node->next = obj->head->next;
    node->prev = obj->head;
    obj->head->next->prev = node;
    obj->head->next = node;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* obj = (LRUCache*)malloc(sizeof(LRUCache));
    obj->capacity = capacity;
    obj->size = 0;

    obj->head = (Node*)malloc(sizeof(Node));
    obj->tail = (Node*)malloc(sizeof(Node));

    obj->head->next = obj->tail;
    obj->tail->prev = obj->head;

    obj->map_size = 20001;
    obj->map = (Node**)calloc(obj->map_size, sizeof(Node*));

    return obj;
}

int lRUCacheGet(LRUCache* obj, int key) {
    if (key < 0 || key >= obj->map_size || obj->map[key] == NULL) {
        return -1;
    }

    Node* node = obj->map[key];

    _remove_node(node);
    _add_to_front(obj, node);

    return node->val;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    if (key < 0 || key >= obj->map_size) {
        return;
    }

    Node* node = obj->map[key];

    if (node != NULL) {
        node->val = value;
        _remove_node(node);
        _add_to_front(obj, node);
    } else {
        Node* new_node = (Node*)malloc(sizeof(Node));
        new_node->key = key;
        new_node->val = value;

        obj->map[key] = new_node;
        _add_to_front(obj, new_node);
        obj->size++;

        if (obj->size > obj->capacity) {
            Node* lru_node = obj->tail->prev;
            _remove_node(lru_node);

            obj->map[lru_node->key] = NULL;

            free(lru_node);
            obj->size--;
        }
    }
}

void lRUCacheFree(LRUCache* obj) {
    Node* current = obj->head->next;
    while (current != obj->tail) {
        Node* next_node = current->next;
        free(current);
        current = next_node;
    }

    free(obj->head);
    free(obj->tail);
    free(obj->map);
    free(obj);
}
#include <stdlib.h>
#include <string.h>

typedef struct HashNode {
    char* str;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** buckets;
    int num_buckets;
    int count; // Number of elements in the hash table
} HashTable;

unsigned long hash_string(const char* str, int num_buckets) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash % num_buckets;
}

HashTable* create_hash_table(int num_buckets) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->num_buckets = num_buckets;
    ht->count = 0;
    ht->buckets = (HashNode**)calloc(num_buckets, sizeof(HashNode*));
    return ht;
}

int hash_insert(HashTable* ht, char* str) {
    unsigned long index = hash_string(str, ht->num_buckets);
    HashNode* current = ht->buckets[index];

    while (current != NULL) {
        if (strcmp(current->str, str) == 0) {
            // String already exists
            return 0;
        }
        current = current->next;
    }

    // String does not exist, insert it
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->str = str; // Take ownership of the string
    newNode->next = ht->buckets[index];
    ht->buckets[index] = newNode;
    ht->count++;
    return 1;
}

void free_hash_table(HashTable* ht) {
    if (!ht) return;
    for (int i = 0; i < ht->num_buckets; i++) {
        HashNode* current = ht->buckets[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp->str); // Free the string itself
            free(temp);
        }
    }
    free(ht->buckets);
    free(ht);
}

typedef struct {
    char** arr;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* create_queue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->arr = (char**)malloc(sizeof(char*) * capacity);
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    return q;
}

int is_empty(Queue* q) {
    return q->size == 0;
}

void enqueue(Queue* q, char* item) {
    if (q->size == q->capacity) {
        int old_capacity = q->capacity;
        q->capacity *= 2;
        q->arr = (char**)realloc(q->arr, sizeof(char*) * q->capacity);

        // If elements are wrapped around, unwrap them to be contiguous
        if (q->front > q->rear) {
            for (int i = 0; i <= q->rear; i++) {
                q->arr[i + old_capacity] = q->arr[i];
            }
            q->rear += old_capacity;
        }
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->arr[q->rear] = item;
    q->size++;
}

char* dequeue(Queue* q) {
    if (is_empty(q)) {
        return NULL;
    }
    char* item = q->arr[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return item;
}

void free_queue(Queue* q) {
    if (!q) return;
    free(q->arr);
    free(q);
}

char* apply_add(const char* s, int a) {
    int n = strlen(s);
    char* res = strdup(s);
    for (int i = 0; i < n; i++) {
        if (i % 2 != 0) { // Odd-indexed positions (0-based: 1, 3, 5...)
            res[i] = ((res[i] - '0' + a) % 10) + '0';
        }
    }
    return res;
}

char* apply_rotate(const char* s, int b) {
    int n = strlen(s);
    b %= n;
    char* res = (char*)malloc(sizeof(char) * (n + 1));
    strncpy(res, s + n - b, b);
    strncpy(res + b, s, n - b);
    res[n] = '\0';
    return res;
}

char* findLexSmallestString(char* s, int a, int b) {
    char* min_s = strdup(s);

    // Max states for N=100 is roughly N*10 = 1000.
    // Queue capacity should be at least this many. Hash table buckets slightly more.
    Queue* q = create_queue(2000); // Initial capacity for queue
    HashTable* visited = create_hash_table(2003); // Use a prime number for buckets

    // Enqueue initial string and mark as visited
    char* initial_s_copy = strdup(s);
    enqueue(q, initial_s_copy);
    hash_insert(visited, initial_s_copy); // Hash table takes ownership of the string

    while (!is_empty(q)) {
        char* current_s = dequeue(q);

        if (strcmp(current_s, min_s) < 0) {
            free(min_s);
            min_s = strdup(current_s);
        }

        // Operation 1: Add 'a' to odd-indexed digits
        char* next_s_add = apply_add(current_s, a);
        if (hash_insert(visited, next_s_add)) { // If newly inserted
            enqueue(q, next_s_add);
        } else {
            free(next_s_add); // String already visited, free the copy
        }

        // Operation 2: Rotate by 'b' positions
        char* next_s_rotate = apply_rotate(current_s, b);
        if (hash_insert(visited, next_s_rotate)) { // If newly inserted
            enqueue(q, next_s_rotate);
        } else {
            free(next_s_rotate); // String already visited, free the copy
        }
    }

    free_queue(q);
    free_hash_table(visited);

    return min_s;
}
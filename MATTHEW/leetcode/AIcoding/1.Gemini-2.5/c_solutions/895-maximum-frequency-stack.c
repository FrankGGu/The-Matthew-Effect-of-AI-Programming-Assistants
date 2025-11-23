#include <stdlib.h>
#include <stdbool.h>

typedef struct Stack {
    int *data;
    int top; // Index of the top element, -1 if empty
    int capacity;
} Stack;

Stack* create_stack() {
    Stack* s = (Stack*)malloc(sizeof(Stack));
    s->capacity = 16; // Initial capacity
    s->data = (int*)malloc(sizeof(int) * s->capacity);
    s->top = -1;
    return s;
}

void push_stack(Stack* s, int val) {
    if (s->top == s->capacity - 1) {
        s->capacity *= 2;
        s->data = (int*)realloc(s->data, sizeof(int) * s->capacity);
    }
    s->data[++s->top] = val;
}

int pop_stack(Stack* s) {
    return s->data[s->top--];
}

bool is_empty_stack(Stack* s) {
    return s->top == -1;
}

void free_stack(Stack* s) {
    if (s) {
        free(s->data);
        free(s);
    }
}

#define FREQ_HASH_TABLE_SIZE 20003 // A prime number

typedef struct FreqEntry {
    int val;
    int freq;
    struct FreqEntry *next;
} FreqEntry;

typedef struct FreqHashTable {
    FreqEntry **buckets;
    int size;
} FreqHashTable;

FreqHashTable* create_freq_hashtable() {
    FreqHashTable* ht = (FreqHashTable*)malloc(sizeof(FreqHashTable));
    ht->size = FREQ_HASH_TABLE_SIZE;
    ht->buckets = (FreqEntry**)calloc(ht->size, sizeof(FreqEntry*));
    return ht;
}

unsigned int hash_freq(int key) {
    return (unsigned int)key % FREQ_HASH_TABLE_SIZE;
}

FreqEntry* find_freq_entry(FreqHashTable* ht, int val) {
    unsigned int index = hash_freq(val);
    FreqEntry* current = ht->buckets[index];
    while (current != NULL) {
        if (current->val == val) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

FreqEntry* get_or_create_freq_entry(FreqHashTable* ht, int val) {
    unsigned int index = hash_freq(val);
    FreqEntry* current = ht->buckets[index];
    while (current != NULL) {
        if (current->val == val) {
            return current;
        }
        current = current->next;
    }

    FreqEntry* new_entry = (FreqEntry*)malloc(sizeof(FreqEntry));
    new_entry->val = val;
    new_entry->freq = 0;
    new_entry->next = ht->buckets[index];
    ht->buckets[index] = new_entry;
    return new_entry;
}

void free_freq_hashtable(FreqHashTable* ht) {
    if (!ht) return;
    for (int i = 0; i < ht->size; ++i) {
        FreqEntry* current = ht->buckets[i];
        while (current != NULL) {
            FreqEntry* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(ht->buckets);
    free(ht);
}

#define GROUP_HASH_TABLE_SIZE 20003 

typedef struct GroupEntry {
    int freq;
    Stack *stack;
    struct GroupEntry *next;
} GroupEntry;

typedef struct GroupHashTable {
    GroupEntry **buckets;
    int size;
} GroupHashTable;

GroupHashTable* create_group_hashtable() {
    GroupHashTable* ht = (GroupHashTable*)malloc(sizeof(GroupHashTable));
    ht->size = GROUP_HASH_TABLE_SIZE;
    ht->buckets = (GroupEntry**)calloc(ht->size, sizeof(GroupEntry*));
    return ht;
}

unsigned int hash_group(int key) {
    return (unsigned int)key % GROUP_HASH_TABLE_SIZE;
}

GroupEntry* find_group_entry(GroupHashTable* ht, int freq) {
    unsigned int index = hash_group(freq);
    GroupEntry* current = ht->buckets[index];
    while (current != NULL) {
        if (current->freq == freq) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

GroupEntry* get_or_create_group_entry(GroupHashTable* ht, int freq) {
    unsigned int index = hash_group(freq);
    GroupEntry* current = ht->buckets[index];
    while (current != NULL) {
        if (current->freq == freq) {
            return current;
        }
        current = current->next;
    }

    GroupEntry* new_entry = (GroupEntry*)malloc(sizeof(GroupEntry));
    new_entry->freq = freq;
    new_entry->stack = create_stack();
    new_entry->next = ht->buckets[index];
    ht->buckets[index] = new_entry;
    return new_entry;
}

void remove_group_entry(GroupHashTable* ht, int freq) {
    unsigned int index = hash_group(freq);
    GroupEntry* current = ht->buckets[index];
    GroupEntry* prev = NULL;

    while (current != NULL) {
        if (current->freq == freq) {
            if (prev == NULL) {
                ht->buckets[index] = current->next;
            } else {
                prev->next = current->next;
            }
            free_stack(current->stack);
            free(current);
            return;
        }
        prev = current;
        current = current->next;
    }
}

void free_group_hashtable(GroupHashTable* ht) {
    if (!ht) return;
    for (int i = 0; i < ht->size; ++i) {
        GroupEntry* current = ht->buckets[i];
        while (current != NULL) {
            GroupEntry* temp = current;
            current = current->next;
            free_stack(temp->stack);
            free(temp);
        }
    }
    free(ht->buckets);
    free(ht);
}

typedef struct {
    FreqHashTable *freq_map;
    GroupHashTable *group_map;
    int max_freq;
} FreqStack;

FreqStack* freqStackCreate() {
    FreqStack* obj = (FreqStack*)malloc(sizeof(FreqStack));
    obj->freq_map = create_freq_hashtable();
    obj->group_map = create_group_hashtable();
    obj->max_freq = 0;
    return obj;
}

void freqStackPush(FreqStack* obj, int val) {
    FreqEntry* freq_entry = get_or_create_freq_entry(obj->freq_map, val);
    freq_entry->freq++;
    int current_freq = freq_entry->freq;

    if (current_freq > obj->max_freq) {
        obj->max_freq = current_freq;
    }

    GroupEntry* group_entry = get_or_create_group_entry(obj->group_map, current_freq);
    push_stack(group_entry->stack, val);
}

int freqStackPop(FreqStack* obj) {
    GroupEntry* group_entry = find_group_entry(obj->group_map, obj->max_freq);

    int popped_val = pop_stack(group_entry->stack);

    FreqEntry* freq_entry = find_freq_entry(obj->freq_map, popped_val);
    freq_entry->freq--;

    if (is_empty_stack(group_entry->stack)) {
        remove_group_entry(obj->group_map, obj->max_freq);
        obj->max_freq--;
    }

    return popped_val;
}

void freqStackFree(FreqStack* obj) {
    if (obj) {
        free_freq_hashtable(obj->freq_map);
        free_group_hashtable(obj->group_map);
        free(obj);
    }
}
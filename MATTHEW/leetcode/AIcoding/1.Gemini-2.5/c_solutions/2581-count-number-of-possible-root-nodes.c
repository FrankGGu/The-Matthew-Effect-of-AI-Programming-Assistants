#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct AdjNode {
    int val;
    struct AdjNode* next;
} AdjNode;

AdjNode** adj;
int n_nodes_global;

void add_edge(int u, int v) {
    AdjNode* newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;

    newNode = (AdjNode*)malloc(sizeof(AdjNode));
    newNode->val = u;
    newNode->next = adj[v];
    adj[v] = newNode;
}

#define HASH_TABLE_SIZE 100003

typedef struct GuessEntry {
    long long key;
    struct GuessEntry* next;
} GuessEntry;

GuessEntry** guesses_hash_table;

unsigned int hash_func(long long key) {
    return (unsigned int)(key % HASH_TABLE_SIZE);
}

void hash_set_add(long long key) {
    unsigned int index = hash_func(key);
    GuessEntry* newEntry = (GuessEntry*)malloc(sizeof(GuessEntry));
    newEntry->key = key;
    newEntry->next = guesses_hash_table[index];
    guesses_hash_table[index] = newEntry;
}

bool hash_set_contains(long long key) {
    unsigned int index = hash_func(key);
    GuessEntry* current = guesses_hash_table[index];
    while (current != NULL) {
        if (current->key == key) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void hash_set_clear_and_free() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        GuessEntry* current = guesses_hash_table[i];
        while (current != NULL) {
            GuessEntry* temp = current;
            current = current->next;
            free(temp);
        }
        guesses_hash_table[i] = NULL;
    }
    free(guesses_hash_table);
    guesses_hash_table = NULL;
}

int k_val_global;
int possible_roots_count_global;
int initial_correct_guesses_for_root_0_global;

void dfs1(int u, int parent) {
    AdjNode* current = adj[u];
    while (current != NULL) {
        int v = current->val;
        if (v == parent) {
            current = current->next;
            continue;
        }
        if (hash_set_contains((long long)u * n_nodes_global + v)) {
            initial_correct_guesses_for_root_0_global++;
        }
        dfs1(v, u);
        current = current->next;
    }
}

void dfs2(int u, int parent, int current_correct_guesses) {
    if (current_correct_guesses >= k_val_global) {
        possible_roots_count_global++;
    }

    AdjNode* current = adj[u];
    while (current != NULL) {
        int v = current->val;
        if (v == parent) {
            current = current->next;
            continue;
        }

        int new_guesses = current_correct_guesses;
        if (hash_set_contains((long long)u * n_nodes_global + v)) {
            new_guesses--;
        }
        if (hash_set_contains((long long)v * n_nodes_global + u)) {
            new_guesses++;
        }

        dfs2(v, u, new_guesses);
        current = current->next;
    }
}

int countPossibleRootNodes(int n, int** edges, int edgesSize, int* edgesColSize, int** guesses, int guessesSize, int* guessesColSize, int k) {
    n_nodes_global = n;
    k_val_global = k;
    possible_roots_count_global = 0;
    initial_correct_guesses_for_root_0_global = 0;

    adj = (AdjNode**)calloc(n, sizeof(AdjNode*));

    for (int i = 0; i < edgesSize; ++i) {
        add_edge(edges[i][0], edges[i][1]);
    }

    guesses_hash_table = (GuessEntry**)calloc(HASH_TABLE_SIZE, sizeof(GuessEntry*));

    for (int i = 0; i < guessesSize; ++i) {
        hash_set_add((long long)guesses[i][0] * n_nodes_global + guesses[i][1]);
    }

    dfs1(0, -1);

    dfs2(0, -1, initial_correct_guesses_for_root_0_global);

    for (int i = 0; i < n; ++i) {
        AdjNode* current = adj[i];
        while (current != NULL) {
            AdjNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    adj = NULL;

    hash_set_clear_and_free();

    return possible_roots_count_global;
}
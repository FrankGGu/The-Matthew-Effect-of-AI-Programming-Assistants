#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int stair;
    int jumps;
} State;

typedef struct Node {
    State key;
    long long value;
    struct Node* next;
} Node;

#define HASH_TABLE_SIZE 200003 
Node* hashTable[HASH_TABLE_SIZE];

unsigned int hash(State s) {
    unsigned int h = 0;
    h = (h * 31 + s.stair);
    h = (h * 31 + s.jumps);
    return h % HASH_TABLE_SIZE;
}

bool state_equals(State s1, State s2) {
    return s1.stair == s2.stair && s1.jumps == s2.jumps;
}

long long get_memo(State key) {
    unsigned int index = hash(key);
    Node* current = hashTable[index];
    while (current != NULL) {
        if (state_equals(current->key, key)) {
            return current->value;
        }
        current = current->next;
    }
    return -1;
}

void put_memo(State key, long long value) {
    unsigned int index = hash(key);
    Node* current = hashTable[index];
    while (current != NULL) {
        if (state_equals(current->key, key)) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

void clear_memo() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Node* current = hashTable[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int K_TARGET;
int MAX_JUMPS_ALLOWED;
long long MOD = 1000000007;

long long solve(int current_stair, int consecutive_up_jumps) {
    if (current_stair < 0) {
        return 0;
    }
    if (current_stair == K_TARGET) {
        return 1;
    }
    if (current_stair > K_TARGET + MAX_JUMPS_ALLOWED + 1) {
        return 0;
    }

    State current_state = {current_stair, consecutive_up_jumps};
    long long memoized_value = get_memo(current_state);
    if (memoized_value != -1) {
        return memoized_value;
    }

    put_memo(current_state, 0); 

    long long ways = 0;

    ways = (ways + solve(current_stair - 1, 0)) % MOD;

    if (consecutive_up_jumps < MAX_JUMPS_ALLOWED) {
        ways = (ways + solve(current_stair + 1, consecutive_up_jumps + 1)) % MOD;
    }

    put_memo(current_state, ways);
    return ways;
}

int numberOfWays(int k, int max_jumps) {
    K_TARGET = k;
    MAX_JUMPS_ALLOWED = max_jumps;

    clear_memo();

    return (int)solve(0, 0);
}
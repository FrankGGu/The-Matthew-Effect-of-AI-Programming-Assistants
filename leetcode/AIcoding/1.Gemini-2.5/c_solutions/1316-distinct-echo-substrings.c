#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define P1 31
#define M1 1000000007
#define P2 37
#define M2 1000000009

#define MAX_S_LEN 2000

#define TABLE_SIZE 100003

long long pow1[MAX_S_LEN + 1];
long long pow2[MAX_S_LEN + 1];
long long prefix_hash1[MAX_S_LEN + 1];
long long prefix_hash2[MAX_S_LEN + 1];

typedef struct HashNode {
    long long h1;
    long long h2;
    struct HashNode* next;
} HashNode;

HashNode* hashTable[TABLE_SIZE];

void initHashTable() {
    for (int i = 0; i < TABLE_SIZE; ++i) {
        hashTable[i] = NULL;
    }
}

void freeHashTable() {
    for (int i = 0; i < TABLE_SIZE; ++i) {
        HashNode* current = hashTable[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
}

void getSubstringHash(int start, int len, long long* out_h1, long long* out_h2) {
    *out_h1 = (prefix_hash1[start + len] - (prefix_hash1[start] * pow1[len]) % M1 + M1) % M1;
    *out_h2 = (prefix_hash2[start + len] - (prefix_hash2[start] * pow2[len]) % M2 + M2) % M2;
}

bool addHashToSet(long long h1, long long h2) {
    unsigned int idx = (unsigned int)(h1 % TABLE_SIZE);

    HashNode* current = hashTable[idx];
    while (current != NULL) {
        if (current->h1 == h1 && current->h2 == h2) {
            return false;
        }
        current = current->next;
    }

    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->h1 = h1;
    newNode->h2 = h2;
    newNode->next = hashTable[idx];
    hashTable[idx] = newNode;
    return true;
}

int distinctEchoSubstrings(char * s){
    int L = strlen(s);

    if (L == 0) {
        return 0;
    }

    pow1[0] = 1;
    pow2[0] = 1;
    for (int i = 1; i <= L; ++i) {
        pow1[i] = (pow1[i-1] * P1) % M1;
        pow2[i] = (pow2[i-1] * P2) % M2;
    }

    prefix_hash1[0] = 0;
    prefix_hash2[0] = 0;
    for (int i = 0; i < L; ++i) {
        prefix_hash1[i+1] = (prefix_hash1[i] * P1 + (s[i] - 'a' + 1)) % M1;
        prefix_hash2[i+1] = (prefix_hash2[i] * P2 + (s[i] - 'a' + 1)) % M2;
    }

    initHashTable();
    int distinctCount = 0;

    long long h1_half1, h2_half1;
    long long h1_half2, h2_half2;
    long long h1_full, h2_full;

    for (int i = 0; i < L; ++i) {
        for (int k = 1; i + 2 * k <= L; ++k) {
            getSubstringHash(i, k, &h1_half1, &h2_half1);
            getSubstringHash(i + k, k, &h1_half2, &h2_half2);

            if (h1_half1 == h1_half2 && h2_half1 == h2_half2) {
                getSubstringHash(i, 2 * k, &h1_full, &h2_full);
                if (addHashToSet(h1_full, h2_full)) {
                    distinctCount++;
                }
            }
        }
    }

    freeHashTable();

    return distinctCount;
}
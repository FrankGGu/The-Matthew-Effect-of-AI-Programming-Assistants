#include <stdlib.h>
#include <string.h>

typedef struct TokenNode {
    char* tokenId;
    int expirationTime;
    struct TokenNode* next;
} TokenNode;

typedef struct {
    int timeToLive;
    TokenNode** hashTable; // Array of pointers to TokenNode (heads of linked lists)
    int tableSize;         // Size of the hash table array
} AuthenticationManager;

static unsigned int hash(const char* str, int tableSize) {
    unsigned int h = 5381; // Initial hash value
    int c;
    while ((c = *str++)) {
        h = ((h << 5) + h) + c; // h * 33 + c
    }
    return h % tableSize;
}

static TokenNode* findToken(AuthenticationManager* obj, const char* tokenId) {
    unsigned int index = hash(tokenId, obj->tableSize);
    TokenNode* current = obj->hashTable[index];
    while (current != NULL) {
        if (strcmp(current->tokenId, tokenId) == 0) {
            return current; // Token found
        }
        current = current->next;
    }
    return NULL; // Token not found
}

AuthenticationManager* authenticationManagerCreate(int timeToLive) {
    AuthenticationManager* obj = (AuthenticationManager*)malloc(sizeof(AuthenticationManager));
    obj->timeToLive = timeToLive;
    obj->tableSize = 5003; // A prime number for hash table size to reduce collisions
    // Allocate hash table array and initialize all pointers to NULL
    obj->hashTable = (TokenNode**)calloc(obj->tableSize, sizeof(TokenNode*));
    return obj;
}

void authenticationManagerGenerate(AuthenticationManager* obj, char* tokenId, int currentTime) {
    TokenNode* node = findToken(obj, tokenId);
    if (node != NULL) {
        // Token already exists, just update its expiration time
        node->expirationTime = currentTime + obj->timeToLive;
    } else {
        // Token does not exist, create a new node
        unsigned int index = hash(tokenId, obj->tableSize);
        TokenNode* newNode = (TokenNode*)malloc(sizeof(TokenNode));
        newNode->tokenId = strdup(tokenId); // Duplicate the tokenId string
        newNode->expirationTime = currentTime + obj->timeToLive;
        // Prepend the new node to the linked list at the calculated index
        newNode->next = obj->hashTable[index];
        obj->hashTable[index] = newNode;
    }
}

void authenticationManagerRenew(AuthenticationManager* obj, char* tokenId, int currentTime) {
    TokenNode* node = findToken(obj, tokenId);
    if (node != NULL) {
        // Check if the token is currently unexpired
        if (node->expirationTime > currentTime) {
            // If unexpired, renew it by updating its expiration time
            node->expirationTime = currentTime + obj->timeToLive;
        }
    }
}

int authenticationManagerCountUnexpiredTokens(AuthenticationManager* obj, int currentTime) {
    int count = 0;
    // Iterate through all buckets of the hash table
    for (int i = 0; i < obj->tableSize; i++) {
        TokenNode* current = obj->hashTable[i];
        // Iterate through the linked list in each bucket
        while (current != NULL) {
            // If the token's expiration time is strictly greater than the current time, it's unexpired
            if (current->expirationTime > currentTime) {
                count++;
            }
            current = current->next;
        }
    }
    return count;
}

void authenticationManagerFree(AuthenticationManager* obj) {
    if (obj == NULL) return;

    // Iterate through all buckets of the hash table
    for (int i = 0; i < obj->tableSize; i++) {
        TokenNode* current = obj->hashTable[i];
        // Free all nodes and their duplicated tokenId strings in each linked list
        while (current != NULL) {
            TokenNode* temp = current;
            current = current->next;
            free(temp->tokenId); // Free the duplicated string
            free(temp);          // Free the token node
        }
    }
    free(obj->hashTable); // Free the hash table array
    free(obj);           // Free the AuthenticationManager object itself
}
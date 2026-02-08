#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct TrieNode {
    struct TrieNode* children[26];
    bool isEndOfWord;
} TrieNode;

TrieNode* trieNodeCreate() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->isEndOfWord = false;
    for (int i = 0; i < 26; i++) {
        node->children[i] = NULL;
    }
    return node;
}

void trieInsertReverse(TrieNode* root, const char* word) {
    int len = strlen(word);
    TrieNode* curr = root;
    for (int i = len - 1; i >= 0; i--) { // Iterate from end to beginning for reverse insertion
        int idx = word[i] - 'a';
        if (!curr->children[idx]) {
            curr->children[idx] = trieNodeCreate();
        }
        curr = curr->children[idx];
    }
    curr->isEndOfWord = true;
}

void trieFree(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < 26; i++) {
        trieFree(node->children[i]);
    }
    free(node);
}

typedef struct {
    TrieNode* root;
    char* history; // Circular buffer to store recent characters
    int head;      // Index of the oldest character in the buffer
    int tail;      // Index where the next character will be written
    int current_size; // Current number of characters in the buffer
    int capacity;  // Maximum capacity of the buffer (max_word_len)
} StreamChecker;

StreamChecker* streamCheckerCreate(char** words, int wordsSize) {
    StreamChecker* obj = (StreamChecker*)malloc(sizeof(StreamChecker));
    obj->root = trieNodeCreate();
    obj->capacity = 0; // Will store the maximum word length

    // Build the reverse Trie and find the maximum word length
    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        if (len > obj->capacity) { // Using capacity to track max_word_len
            obj->capacity = len;
        }
        trieInsertReverse(obj->root, words[i]);
    }

    // If no words were provided, capacity would be 0. Allocate at least 1 to avoid malloc(0).
    if (obj->capacity == 0) obj->capacity = 1;

    // Initialize circular buffer
    obj->history = (char*)malloc(sizeof(char) * obj->capacity);
    obj->head = 0;
    obj->tail = 0;
    obj->current_size = 0;

    return obj;
}

bool streamCheckerQuery(StreamChecker* obj, char letter) {
    // Add the new letter to the circular history buffer
    obj->history[obj->tail] = letter;
    obj->tail = (obj->tail + 1) % obj->capacity;

    if (obj->current_size < obj->capacity) {
        obj->current_size++;
    } else {
        // Buffer was full, the new character overwrote the oldest one,
        // so advance head to the next oldest.
        obj->head = (obj->head + 1) % obj->capacity;
    }

    // Traverse the reverse Trie using the recent characters from history
    TrieNode* curr = obj->root;
    // Iterate backwards from the most recent character in the history
    for (int k = 0; k < obj->current_size; k++) {
        // Calculate the index for the k-th character from the end of the logical buffer
        // (obj->tail - 1) is the index of the most recent character.
        // Subtract k to go backwards, and add obj->capacity to handle negative results of modulo.
        int i = (obj->tail - 1 - k + obj->capacity) % obj->capacity;
        int idx = obj->history[i] - 'a';

        if (!curr->children[idx]) {
            // No path in the Trie for this suffix, so no word can be formed
            return false; 
        }
        curr = curr->children[idx];
        if (curr->isEndOfWord) {
            // Found a word ending at this point in the suffix
            return true; 
        }
    }
    return false; // No matching word found in any suffix
}

void streamCheckerFree(StreamChecker* obj) {
    trieFree(obj->root);
    free(obj->history);
    free(obj);
}
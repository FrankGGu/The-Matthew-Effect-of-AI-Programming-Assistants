#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define ALPHABET_SIZE 26

typedef struct TrieNode {
    struct TrieNode* children[ALPHABET_SIZE];
    int word_idx; // Stores the index of the word if a word ends at this node, -1 otherwise.
    int* palindrome_suffix_indices; // Stores indices of words that have a palindrome suffix starting from this node.
    int palindrome_suffix_count;
    int palindrome_suffix_capacity;
} TrieNode;

TrieNode* createTrieNode() {
    TrieNode* node = (TrieNode*)malloc(sizeof(TrieNode));
    node->word_idx = -1;
    node->palindrome_suffix_indices = NULL;
    node->palindrome_suffix_count = 0;
    node->palindrome_suffix_capacity = 0;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        node->children[i] = NULL;
    }
    return node;
}

bool isPalindromeSubstr(const char* s, int start, int end) {
    if (start >= end) return true; // Empty or single character substring is a palindrome
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

void insertWord(TrieNode* root, const char* word, int index) {
    TrieNode* curr = root;
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
        // If the suffix of `word` starting from `i` is a palindrome,
        // add `index` to the current node's palindrome_suffix_indices list.
        // This is for cases where `words[j]` (the word being searched) is shorter than `words[i]` (the word in Trie).
        // If `words[j] + words[i]` is a palindrome, and `words[i]` is `prefix + suffix_palindrome`,
        // then `words[j]` must be `reverse(prefix)`.
        // Here, `prefix` is `word[0...i-1]`, and `suffix_palindrome` is `word[i...len-1]`.
        if (isPalindromeSubstr(word, i, len - 1)) {
            if (curr->palindrome_suffix_count >= curr->palindrome_suffix_capacity) {
                curr->palindrome_suffix_capacity = (curr->palindrome_suffix_capacity == 0) ? 2 : curr->palindrome_suffix_capacity * 2;
                curr->palindrome_suffix_indices = (int*)realloc(curr->palindrome_suffix_indices, curr->palindrome_suffix_capacity * sizeof(int));
            }
            curr->palindrome_suffix_indices[curr->palindrome_suffix_count++] = index;
        }

        int char_idx = word[i] - 'a';
        if (curr->children[char_idx] == NULL) {
            curr->children[char_idx] = createTrieNode();
        }
        curr = curr->children[char_idx];
    }
    curr->word_idx = index; // Mark the end of the word
}

char* reverseString(const char* s) {
    int len = strlen(s);
    char* reversed = (char*)malloc(len + 1);
    if (!reversed) return NULL; // Handle allocation failure
    for (int i = 0; i < len; i++) {
        reversed[i] = s[len - 1 - i];
    }
    reversed[len] = '\0';
    return reversed;
}

typedef struct {
    int* data;
    int capacity;
    int size;
} IntArray;

void initIntArray(IntArray* arr) {
    arr->size = 0;
    arr->capacity = 10; 
    arr->data = (int*)malloc(arr->capacity * 2 * sizeof(int));
}

void addPair(IntArray* arr, int val1, int val2) {
    if (arr->size >= arr->capacity) {
        arr->capacity *= 2;
        arr->data = (int*)realloc(arr->data, arr->capacity * 2 * sizeof(int));
    }
    arr->data[arr->size * 2] = val1;
    arr->data[arr->size * 2 + 1] = val2;
    arr->size++;
}

void freeTrie(TrieNode* node) {
    if (!node) return;
    for (int i = 0; i < ALPHABET_SIZE; i++) {
        freeTrie(node->children[i]);
    }
    free(node->palindrome_suffix_indices);
    free(node);
}

int comparePairs(const void* a, const void* b) {
    const int* pairA = *(const int**)a;
    const int* pairB = *(const int**)b;
    if (pairA[0] != pairB[0]) {
        return pairA[0] - pairB[0];
    }
    return pairA[1] - pairB[1];
}

int** palindromePairs(char** words, int wordsSize, int* returnSize, int** returnColumnSizes) {
    TrieNode* root = createTrieNode();

    // Build Trie with all words
    for (int i = 0; i < wordsSize; i++) {
        insertWord(root, words[i], i);
    }

    IntArray result_pairs;
    initIntArray(&result_pairs);

    for (int i = 0; i < wordsSize; i++) {
        const char* s = words[i];
        int len_s = strlen(s);
        char* rev_s = reverseString(s); // Reverse of the current word
        TrieNode* curr = root;

        for (int j = 0; j < len_s; j++) { // j is current character index in rev_s
            // Case 1: `words[i]` (current word) is longer than `words[idx_trie]` (word found in Trie).
            // `words[i]` = `prefix_of_s` + `suffix_of_s`.
            // `words[idx_trie]` is `reverse(prefix_of_s)`.
            // If `suffix_of_s` is a palindrome, then `words[idx_trie] + words[i]` is a palindrome.
            // When traversing Trie with `rev_s`, `curr->word_idx` means `words[curr->word_idx]` is `reverse(rev_s[0...j-1])`.
            // `rev_s[0...j-1]` is `reverse(s[0...j-1])`.
            // So `words[curr->word_idx]` is `s[0...j-1]`. This is not correct.
            // `words[curr->word_idx]` is `reverse(rev_s[0...j-1])`.
            // `words[curr->word_idx]` is `reverse(prefix_of_rev_s)`.
            // `s` is `reverse(rev_s)`.
            // So `words[curr->word_idx]` is `s[len_s - (j)...len_s-1]` (suffix of s).
            // If `words[curr->word_idx]` is found, and `s[0...len_s-(j)-1]` is a palindrome.
            // This is complex. Let's use the standard interpretation:
            // If `curr->word_idx` exists (meaning `rev_s[0...j-1]` forms a complete word in the Trie)
            // AND the remaining part of `rev_s` (`rev_s[j...len_s-1]`) is a palindrome,
            // THEN `words[i]` + `words[curr->word_idx]` is a palindrome.
            // (i.e., `s` + `reverse(rev_s[0...j-1])` is a palindrome).
            // This means `s` + `s[len_s-j...len_s-1]` is a palindrome.
            // This is `s[0...len_s-1]` + `s[len_s-j...len_s-1]`. This is wrong.

            // Correct interpretation for `curr->word_idx != -1`:
            // `rev_s[0...j-1]` is a prefix of some `words[idx_trie]` (stored at `curr->word_idx`).
            // So `words[idx_trie]` is `rev_s[0...j-1]`.
            // This means `words[idx_trie]` is `reverse(s[0...j-1])`.
            // If `s[j...len_s-1]` is a palindrome, then `words[idx_trie] + s` is a palindrome.
            // Add `(curr->word_idx, i)`.
            if (curr->word_idx != -1 && curr->word_idx != i && isPalindromeSubstr(s, 0, len_s - j - 1)) {
                addPair(&result_pairs, curr->word_idx, i);
            }

            int char_idx = rev_s[j] - 'a';
            if (curr->children[char_idx] == NULL) {
                curr = NULL; // No path in Trie for this character
                break;
            }
            curr = curr->children[char_idx];
        }

        if (curr != NULL) {
            // Case 2: `words[i]` (current word) is an exact match for a word in Trie.
            // This means `s` is `reverse(words[idx_trie])`.
            // If `s` is `reverse(words[idx_trie])`, then `s + words[idx_trie]` is a palindrome.
            // This happens when `rev_s` fully matches a word in the Trie.
            if (curr->word_idx != -1 && curr->word_idx != i) {
                addPair(&result_pairs, i, curr->word_idx);
            }

            // Case 3: `words[i]` (current word) is shorter than `words[idx_trie]` (word in Trie).
            // If `words[idx_trie]` has a suffix (from current `curr` node) that is a palindrome,
            // then `s + words[idx_trie]` is a palindrome.
            // (i.e., `s` + `words[idx_trie]` where `words[idx_trie]` is `reverse(s)` + `palindrome_suffix`).
            for (int k = 0; k < curr->palindrome_suffix_count; k++) {
                int idx_trie = curr->palindrome_suffix_indices[k];
                if (idx_trie != i) {
                    addPair(&result_pairs, i, idx_trie);
                }
            }
        }
        free(rev_s);
    }

    // Convert IntArray to LeetCode's required format
    // Sort and remove duplicates
    qsort(result_pairs.data, result_pairs.size, 2 * sizeof(int), comparePairs);

    int unique_size = 0;
    if (result_pairs.size > 0) {
        unique_size = 1;
        for (int i = 1; i < result_pairs.size; i++) {
            if (result_pairs.data[i * 2] != result_pairs.data[(i - 1) * 2] ||
                result_pairs.data[i * 2 + 1] != result_pairs.data[(i - 1) * 2 + 1]) {
                result_pairs.data[unique_size * 2] = result_pairs.data[i * 2];
                result_pairs.data[unique_size * 2 + 1] = result_pairs.data[i * 2 + 1];
                unique_size++;
            }
        }
    }

    *returnSize = unique_size;
    *returnColumnSizes = (int*)malloc(unique_size * sizeof(int));
    int** result_matrix = (int**)malloc(unique_size * sizeof(int*));

    for (int i = 0; i < unique_size; i++) {
        (*returnColumnSizes)[i] = 2;
        result_matrix[i] = (int*)malloc(2 * sizeof(int));
        result_matrix[i][0] = result_pairs.data[i * 2];
        result_matrix[i][1] = result_pairs.data[i * 2 + 1];
    }

    free(result_pairs.data);
    freeTrie(root);

    return result_matrix;
}
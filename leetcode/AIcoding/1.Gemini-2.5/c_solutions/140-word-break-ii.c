#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_SENTENCE_LEN 41

char** g_results;
int g_results_count;
int g_results_capacity;

char* g_s_ptr;
int g_s_len_ptr;
char** g_wordDict_ptr;
int g_wordDictSize_ptr;

int* g_memo_can_break; 

static bool is_in_dict(const char* word, int word_len) {
    for (int i = 0; i < g_wordDictSize_ptr; i++) {
        if (strlen(g_wordDict_ptr[i]) == word_len && strncmp(word, g_wordDict_ptr[i], word_len) == 0) {
            return true;
        }
    }
    return false;
}

static bool can_segment(int start_idx) {
    if (start_idx == g_s_len_ptr) {
        return true; // Empty string can always be segmented
    }
    if (g_memo_can_break[start_idx] != -1) {
        return g_memo_can_break[start_idx];
    }

    for (int i = start_idx; i < g_s_len_ptr; i++) {
        int word_len = i - start_idx + 1;
        if (is_in_dict(g_s_ptr + start_idx, word_len)) {
            if (can_segment(i + 1)) {
                g_memo_can_break[start_idx] = 1; // Mark as true
                return true;
            }
        }
    }
    g_memo_can_break[start_idx] = 0; // Mark as false
    return false;
}

static void backtrack(int start_idx, char* current_sentence_buffer, int current_sentence_len) {
    if (start_idx == g_s_len_ptr) {
        // Reached the end of the string, a valid sentence is formed.
        // Trim the trailing space and null-terminate.
        current_sentence_buffer[current_sentence_len - 1] = '\0';

        // Add the completed sentence to the results list
        if (g_results_count == g_results_capacity) {
            g_results_capacity *= 2;
            g_results = (char**)realloc(g_results, g_results_capacity * sizeof(char*));
        }
        g_results[g_results_count] = (char*)malloc(strlen(current_sentence_buffer) + 1);
        strcpy(g_results[g_results_count], current_sentence_buffer);
        g_results_count++;
        return;
    }

    // Pruning step: If the current suffix s[start_idx...] cannot be segmented,
    // there's no need to explore this path further.
    if (!can_segment(start_idx)) {
        return;
    }

    // Iterate through all possible end points for the current word
    for (int i = start_idx; i < g_s_len_ptr; i++) {
        int word_len = i - start_idx + 1;

        // Check if the substring s[start_idx...i] is a valid dictionary word
        if (is_in_dict(g_s_ptr + start_idx, word_len)) {
            // Store the current length of the sentence buffer for backtracking
            int prev_len = current_sentence_len;

            // Append the current word to the sentence buffer
            strncpy(current_sentence_buffer + current_sentence_len, g_s_ptr + start_idx, word_len);
            current_sentence_len += word_len;

            // Append a space after the word
            current_sentence_buffer[current_sentence_len] = ' ';
            current_sentence_len++;

            // Recursively call backtrack for the remaining part of the string
            backtrack(i + 1, current_sentence_buffer, current_sentence_len);

            // Backtrack: restore the sentence buffer length to remove the appended word and space
            current_sentence_len = prev_len;
        }
    }
}

char** wordBreak(char* s, char** wordDict, int wordDictSize, int* returnSize) {
    g_s_len_ptr = strlen(s);
    g_s_ptr = s;
    g_wordDict_ptr = wordDict;
    g_wordDictSize_ptr = wordDictSize;

    // Initialize global results storage
    g_results_count = 0;
    g_results_capacity = 10; // Initial capacity, will be doubled as needed
    g_results = (char**)malloc(g_results_capacity * sizeof(char*));

    // Initialize memoization table for `can_segment`
    g_memo_can_break = (int*)malloc((g_s_len_ptr + 1) * sizeof(int));
    for (int i = 0; i <= g_s_len_ptr; i++) {
        g_memo_can_break[i] = -1; // -1 indicates not computed yet
    }

    // Buffer to build the current sentence.
    // It's allocated on the stack as its max size is small (MAX_SENTENCE_LEN).
    char current_sentence_buffer[MAX_SENTENCE_LEN]; 

    // Start the backtracking process from the beginning of the string
    backtrack(0, current_sentence_buffer, 0);

    // Free the memoization table
    free(g_memo_can_break);

    // Set the count of results found
    *returnSize = g_results_count;
    return g_results;
}
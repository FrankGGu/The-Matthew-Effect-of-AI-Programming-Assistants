#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    char** words;
    int count;
    int capacity;
} StringSet;

char* g_expression_ptr;

StringSet* createStringSet();
void freeStringSet(StringSet* set);
void addWord(StringSet* set, const char* word);
StringSet* unionSets(StringSet* set1, StringSet* set2);
StringSet* concatenateSets(StringSet* set1, StringSet* set2);
int compareStrings(const void* a, const void* b);

StringSet* parseExpression();
StringSet* parseTerm();
StringSet* parseFactor();

StringSet* createStringSet() {
    StringSet* set = (StringSet*)malloc(sizeof(StringSet));
    set->count = 0;
    set->capacity = 8; // Initial capacity, will grow as needed
    set->words = (char**)malloc(set->capacity * sizeof(char*));
    return set;
}

void freeStringSet(StringSet* set) {
    if (set == NULL) return;
    for (int i = 0; i < set->count; i++) {
        free(set->words[i]);
    }
    free(set->words);
    free(set);
}

void addWord(StringSet* set, const char* word) {
    int len = strlen(word);
    if (len == 0 || len > 10) { // Constraint: words in final output length 1 to 10
        return;
    }

    if (set->count == set->capacity) {
        set->capacity *= 2;
        set->words = (char**)realloc(set->words, set->capacity * sizeof(char*));
    }
    set->words[set->count] = strdup(word);
    set->count++;
}

StringSet* unionSets(StringSet* set1, StringSet* set2) {
    StringSet* result = createStringSet();
    for (int i = 0; i < set1->count; i++) {
        addWord(result, set1->words[i]);
    }
    for (int i = 0; i < set2->count; i++) {
        addWord(result, set2->words[i]);
    }
    return result;
}

StringSet* concatenateSets(StringSet* set1, StringSet* set2) {
    StringSet* result = createStringSet();
    if (set1->count == 0 || set2->count == 0) {
        return result; // Concatenation with an empty set results in an empty set
    }

    for (int i = 0; i < set1->count; i++) {
        for (int j = 0; j < set2->count; j++) {
            int new_len = strlen(set1->words[i]) + strlen(set2->words[j]);
            if (new_len > 10) { // Prune words that would exceed max length
                continue;
            }
            char* new_word = (char*)malloc(new_len + 1);
            strcpy(new_word, set1->words[i]);
            strcat(new_word, set2->words[j]);
            addWord(result, new_word); // addWord makes a copy, so new_word can be freed
            free(new_word);
        }
    }
    return result;
}

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

StringSet* parseExpression() {
    StringSet* current_set = parseTerm();
    while (*g_expression_ptr == ',') {
        g_expression_ptr++; // Consume ','
        StringSet* next_term_set = parseTerm();
        StringSet* temp = unionSets(current_set, next_term_set);
        freeStringSet(current_set);
        freeStringSet(next_term_set);
        current_set = temp;
    }
    return current_set;
}

StringSet* parseTerm() {
    StringSet* current_set = parseFactor();
    // Continue concatenating factors as long as we don't hit ',', '}', or end of string
    while (*g_expression_ptr != ',' && *g_expression_ptr != '}' && *g_expression_ptr != '\0') {
        StringSet* next_factor_set = parseFactor();
        StringSet* temp = concatenateSets(current_set, next_factor_set);
        freeStringSet(current_set);
        freeStringSet(next_factor_set);
        current_set = temp;
    }
    return current_set;
}

StringSet* parseFactor() {
    StringSet* set = createStringSet();
    if (*g_expression_ptr == '{') {
        g_expression_ptr++; // Consume '{'
        freeStringSet(set); // Free the empty set created above, as parseExpression will return a new one
        set = parseExpression();
        g_expression_ptr++; // Consume '}'
    } else { // Must be a letter
        char letter[2];
        letter[0] = *g_expression_ptr;
        letter[1] = '\0';
        addWord(set, letter);
        g_expression_ptr++; // Consume letter
    }
    return set;
}

char** braceExpansionII(char* expression, int* returnSize) {
    g_expression_ptr = expression;

    // Parse the entire expression
    StringSet* result_set = parseExpression();

    // Sort the words in the result set
    qsort(result_set->words, result_set->count, sizeof(char*), compareStrings);

    // Deduplicate and prepare final output
    StringSet* final_unique_set = createStringSet();
    if (result_set->count > 0) {
        addWord(final_unique_set, result_set->words[0]); // addWord makes a copy
        for (int i = 1; i < result_set->count; i++) {
            // Compare with the last unique word added
            if (strcmp(result_set->words[i], final_unique_set->words[final_unique_set->count - 1]) != 0) {
                addWord(final_unique_set, result_set->words[i]);
            }
        }
    }

    // Free the intermediate result_set and its words.
    // Words that were copied to final_unique_set are now owned by final_unique_set.
    // Words that were duplicates in result_set are freed here.
    freeStringSet(result_set);

    // Prepare the output for LeetCode
    *returnSize = final_unique_set->count;
    char** output = final_unique_set->words; // Transfer ownership of the words array

    // Free the final_unique_set structure itself, but not the words array it contains
    free(final_unique_set);

    return output;
}
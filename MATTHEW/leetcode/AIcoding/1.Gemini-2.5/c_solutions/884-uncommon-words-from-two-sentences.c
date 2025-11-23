#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 21 // Maximum word length 20 + null terminator
#define MAX_UNIQUE_WORDS 200 // Maximum total words in both sentences is 200, so max unique words is also 200

typedef struct {
    char word[MAX_WORD_LEN];
    int count;
} WordCount;

char ** uncommonFromSentences(char * s1, char * s2, int* returnSize) {
    // Array to store unique words and their counts
    WordCount wordCounts[MAX_UNIQUE_WORDS];
    int uniqueWordCount = 0;

    // Make copies of s1 and s2 because strtok_r modifies the string.
    // strdup allocates memory, which must be freed later.
    char *s1_copy = strdup(s1);
    char *s2_copy = strdup(s2);

    char *token;
    char *saveptr; // Pointer used by strtok_r to maintain state

    // Process s1 to count word frequencies
    token = strtok_r(s1_copy, " ", &saveptr);
    while (token != NULL) {
        int found = 0;
        // Search if the word already exists in our wordCounts array
        for (int i = 0; i < uniqueWordCount; i++) {
            if (strcmp(wordCounts[i].word, token) == 0) {
                wordCounts[i].count++;
                found = 1;
                break;
            }
        }
        // If the word is not found, add it to the array
        if (!found) {
            // Ensure we don't exceed the maximum number of unique words
            if (uniqueWordCount < MAX_UNIQUE_WORDS) {
                strncpy(wordCounts[uniqueWordCount].word, token, MAX_WORD_LEN - 1);
                wordCounts[uniqueWordCount].word[MAX_WORD_LEN - 1] = '\0'; // Ensure null termination
                wordCounts[uniqueWordCount].count = 1;
                uniqueWordCount++;
            }
        }
        token = strtok_r(NULL, " ", &saveptr); // Get the next token
    }

    // Process s2 to count word frequencies
    // The saveptr will be re-initialized by strtok_r when called with s2_copy
    token = strtok_r(s2_copy, " ", &saveptr);
    while (token != NULL) {
        int found = 0;
        // Search if the word already exists
        for (int i = 0; i < uniqueWordCount; i++) {
            if (strcmp(wordCounts[i].word, token) == 0) {
                wordCounts[i].count++;
                found = 1;
                break;
            }
        }
        // If the word is not found, add it
        if (!found) {
            if (uniqueWordCount < MAX_UNIQUE_WORDS) {
                strncpy(wordCounts[uniqueWordCount].word, token, MAX_WORD_LEN - 1);
                wordCounts[uniqueWordCount].word[MAX_WORD_LEN - 1] = '\0'; // Ensure null termination
                wordCounts[uniqueWordCount].count = 1;
                uniqueWordCount++;
            }
        }
        token = strtok_r(NULL, " ", &saveptr); // Get the next token
    }

    // Collect uncommon words (those with a count of 1)
    // Allocate memory for the result array of string pointers
    char **result = (char **)malloc(MAX_UNIQUE_WORDS * sizeof(char *));
    int resultCount = 0;

    for (int i = 0; i < uniqueWordCount; i++) {
        if (wordCounts[i].count == 1) {
            // Allocate memory for the word string itself
            result[resultCount] = (char *)malloc((strlen(wordCounts[i].word) + 1) * sizeof(char));
            strcpy(result[resultCount], wordCounts[i].word);
            resultCount++;
        }
    }

    // Set the size of the returned array
    *returnSize = resultCount;

    // Free the dynamically allocated copies of the input strings
    free(s1_copy);
    free(s2_copy);

    return result;
}
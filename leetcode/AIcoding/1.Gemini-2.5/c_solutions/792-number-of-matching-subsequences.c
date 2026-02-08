#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

typedef struct WordState {
    int word_idx;
    int char_idx;
    struct WordState *next;
} WordState;

WordState *heads[26];
WordState *tails[26];

void addWordState(int char_code, int word_idx, int char_idx) {
    WordState *newState = (WordState *)malloc(sizeof(WordState));
    newState->word_idx = word_idx;
    newState->char_idx = char_idx;
    newState->next = NULL;

    if (heads[char_code] == NULL) {
        heads[char_code] = newState;
        tails[char_code] = newState;
    } else {
        tails[char_code]->next = newState;
        tails[char_code] = newState;
    }
}

void freeRemainingWordStates() {
    for (int i = 0; i < 26; ++i) {
        WordState *current = heads[i];
        while (current != NULL) {
            WordState *temp = current;
            current = current->next;
            free(temp);
        }
        heads[i] = NULL;
        tails[i] = NULL;
    }
}

int numMatchingSubsequences(char *s, char **words, int wordsSize) {
    for (int i = 0; i < 26; ++i) {
        heads[i] = NULL;
        tails[i] = NULL;
    }

    for (int i = 0; i < wordsSize; ++i) {
        addWordState(words[i][0] - 'a', i, 0);
    }

    int count = 0;

    for (int i = 0; s[i] != '\0'; ++i) {
        int char_code = s[i] - 'a';

        WordState *current_list_head = heads[char_code];
        heads[char_code] = NULL; 
        tails[char_code] = NULL; 

        WordState *current = current_list_head;
        while (current != NULL) {
            int word_idx = current->word_idx;
            int char_idx = current->char_idx + 1;

            if (words[word_idx][char_idx] == '\0') {
                count++;
            } else {
                addWordState(words[word_idx][char_idx] - 'a', word_idx, char_idx);
            }

            WordState *temp = current;
            current = current->next;
            free(temp);
        }
    }

    freeRemainingWordStates();

    return count;
}
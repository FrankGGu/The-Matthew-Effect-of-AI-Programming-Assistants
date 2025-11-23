#include <stdlib.h>
#include <string.h>
#include <ctype.h>

typedef struct {
    char* start;
    int length;
    int original_index;
} Word;

int compareWords(const void* a, const void* b) {
    Word* wordA = (Word*)a;
    Word* wordB = (Word*)b;

    if (wordA->length != wordB->length) {
        return wordA->length - wordB->length;
    }
    return wordA->original_index - wordB->original_index;
}

char* rearrangeWords(char* text) {
    int len = strlen(text);
    int num_words = 0;
    for (int i = 0; i < len; i++) {
        if (text[i] == ' ') {
            num_words++;
        }
    }
    num_words++;

    Word* words = (Word*)malloc(num_words * sizeof(Word));
    if (words == NULL) {
        return NULL;
    }

    int word_idx = 0;
    char* current_word_start = text;
    for (int i = 0; i <= len; i++) {
        if (text[i] == ' ' || text[i] == '\0') {
            words[word_idx].start = current_word_start;
            words[word_idx].length = &text[i] - current_word_start;
            words[word_idx].original_index = current_word_start - text;
            word_idx++;
            current_word_start = &text[i + 1];
        }
    }

    qsort(words, num_words, sizeof(Word), compareWords);

    char* result = (char*)malloc(len + 1);
    if (result == NULL) {
        free(words);
        return NULL;
    }

    char* current_pos = result;
    for (int i = 0; i < num_words; i++) {
        Word* current_word = &words[i];

        if (i > 0) {
            *current_pos = ' ';
            current_pos++;
        }

        if (i == 0) {
            *current_pos = toupper(current_word->start[0]);
        } else {
            *current_pos = tolower(current_word->start[0]);
        }
        current_pos++;

        if (current_word->length > 1) {
            memcpy(current_pos, current_word->start + 1, current_word->length - 1);
            current_pos += current_word->length - 1;
        }
    }

    *current_pos = '\0';

    free(words);

    return result;
}
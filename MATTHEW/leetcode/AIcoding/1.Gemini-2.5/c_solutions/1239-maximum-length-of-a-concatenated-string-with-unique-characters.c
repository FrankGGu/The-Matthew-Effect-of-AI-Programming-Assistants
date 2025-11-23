#include <string.h>
#include <stdbool.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int global_max_len_val;

typedef struct {
    int mask;
    int len;
} WordData;

void backtrack_optimized(int index, int current_mask, int current_length, WordData *validWords, int validWordsSize) {
    global_max_len_val = max(global_max_len_val, current_length);

    if (index == validWordsSize) {
        return;
    }

    backtrack_optimized(index + 1, current_mask, current_length, validWords, validWordsSize);

    int word_mask = validWords[index].mask;
    int word_len = validWords[index].len;

    if ((current_mask & word_mask) == 0) {
        backtrack_optimized(index + 1, current_mask | word_mask, current_length + word_len, validWords, validWordsSize);
    }
}

int maxLength(char **arr, int arrSize) {
    global_max_len_val = 0;

    WordData validWords[arrSize];
    int validWordsCount = 0;

    for (int i = 0; i < arrSize; ++i) {
        int word_mask = 0;
        int word_len = 0;
        bool is_unique_in_word = true;

        for (int j = 0; arr[i][j] != '\0'; ++j) {
            int char_bit = 1 << (arr[i][j] - 'a');
            if ((word_mask & char_bit) != 0) {
                is_unique_in_word = false;
                break;
            }
            word_mask |= char_bit;
            word_len++;
        }

        if (is_unique_in_word) {
            validWords[validWordsCount].mask = word_mask;
            validWords[validWordsCount].len = word_len;
            validWordsCount++;
        }
    }

    backtrack_optimized(0, 0, 0, validWords, validWordsCount);
    return global_max_len_val;
}
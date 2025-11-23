#include <stdbool.h>
#include <string.h>
#include <stdlib.h> 

int char_to_digit[26];
bool digit_used[10];
bool is_leading[26];
char unique_chars[10];
int num_unique_chars;

long long get_word_value(char* word) {
    long long value = 0;
    for (int i = 0; i < strlen(word); i++) {
        value = value * 10 + char_to_digit[word[i] - 'A'];
    }
    return value;
}

bool solve(char** words, int wordsSize, char* result, int char_idx) {
    if (char_idx == num_unique_chars) {
        long long sum = 0;
        for (int i = 0; i < wordsSize; i++) {
            sum += get_word_value(words[i]);
        }
        long long result_value = get_word_value(result);
        return sum == result_value;
    }

    char current_char = unique_chars[char_idx];

    for (int digit = 0; digit <= 9; digit++) {
        if (digit_used[digit]) {
            continue;
        }
        if (is_leading[current_char - 'A'] && digit == 0) {
            continue;
        }

        char_to_digit[current_char - 'A'] = digit;
        digit_used[digit] = true;

        if (solve(words, wordsSize, result, char_idx + 1)) {
            return true;
        }

        digit_used[digit] = false;
        char_to_digit[current_char - 'A'] = -1;
    }

    return false;
}

bool isSolvable(char** words, int wordsSize, char* result) {
    for (int i = 0; i < 26; i++) {
        char_to_digit[i] = -1;
        is_leading[i] = false;
    }
    for (int i = 0; i < 10; i++) {
        digit_used[i] = false;
    }
    num_unique_chars = 0;

    bool char_seen[26] = {false};

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        if (strlen(word) > 1) {
            is_leading[word[0] - 'A'] = true;
        }
        for (int j = 0; j < strlen(word); j++) {
            if (!char_seen[word[j] - 'A']) {
                char_seen[word[j] - 'A'] = true;
                unique_chars[num_unique_chars++] = word[j];
            }
        }
    }

    char* res_word = result;
    if (strlen(res_word) > 1) {
        is_leading[res_word[0] - 'A'] = true;
    }
    for (int j = 0; j < strlen(res_word); j++) {
        if (!char_seen[res_word[j] - 'A']) {
            char_seen[res_word[j] - 'A'] = true;
            unique_chars[num_unique_chars++] = res_word[j];
        }
    }

    return solve(words, wordsSize, result, 0);
}
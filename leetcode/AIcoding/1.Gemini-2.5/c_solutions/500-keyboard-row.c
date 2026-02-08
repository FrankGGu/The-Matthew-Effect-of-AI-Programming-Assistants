#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char** findWords(char** words, int wordsSize, int* returnSize) {
    int row_map[26];

    row_map['q' - 'a'] = 1; row_map['w' - 'a'] = 1; row_map['e' - 'a'] = 1;
    row_map['r' - 'a'] = 1; row_map['t' - 'a'] = 1; row_map['y' - 'a'] = 1;
    row_map['u' - 'a'] = 1; row_map['i' - 'a'] = 1; row_map['o' - 'a'] = 1;
    row_map['p' - 'a'] = 1;

    row_map['a' - 'a'] = 2; row_map['s' - 'a'] = 2; row_map['d' - 'a'] = 2;
    row_map['f' - 'a'] = 2; row_map['g' - 'a'] = 2; row_map['h' - 'a'] = 2;
    row_map['j' - 'a'] = 2; row_map['k' - 'a'] = 2; row_map['l' - 'a'] = 2;

    row_map['z' - 'a'] = 3; row_map['x' - 'a'] = 3; row_map['c' - 'a'] = 3;
    row_map['v' - 'a'] = 3; row_map['b' - 'a'] = 3; row_map['n' - 'a'] = 3;
    row_map['m' - 'a'] = 3;

    char** result = (char**)malloc(sizeof(char*) * wordsSize);
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* current_word = words[i];
        if (current_word == NULL || current_word[0] == '\0') {
            continue;
        }

        int first_char_row = row_map[tolower(current_word[0]) - 'a'];
        int is_valid_word = 1;

        for (int j = 1; current_word[j] != '\0'; j++) {
            if (row_map[tolower(current_word[j]) - 'a'] != first_char_row) {
                is_valid_word = 0;
                break;
            }
        }

        if (is_valid_word) {
            result[count] = (char*)malloc(sizeof(char) * (strlen(current_word) + 1));
            strcpy(result[count], current_word);
            count++;
        }
    }

    *returnSize = count;
    return result;
}
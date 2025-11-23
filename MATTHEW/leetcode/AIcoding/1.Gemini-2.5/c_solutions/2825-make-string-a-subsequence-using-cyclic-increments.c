#include <stdbool.h>
#include <string.h>

bool canMakeSubsequence(char *str1, char *str2) {
    int p1 = 0;
    int p2 = 0;
    int len1 = strlen(str1);
    int len2 = strlen(str2);

    while (p1 < len1 && p2 < len2) {
        char current_char_str1 = str1[p1];
        char target_char_str2 = str2[p2];

        if (current_char_str1 == target_char_str2) {
            p2++;
        } else {
            char next_char_str1 = (current_char_str1 - 'a' + 1) % 26 + 'a';
            if (next_char_str1 == target_char_str2) {
                p2++;
            }
        }
        p1++;
    }

    return p2 == len2;
}
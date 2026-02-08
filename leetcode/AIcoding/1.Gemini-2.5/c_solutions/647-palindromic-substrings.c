#include <string.h>

int expandAndCount(char *s, int left, int right, int s_len) {
    int count = 0;
    while (left >= 0 && right < s_len && s[left] == s[right]) {
        count++;
        left--;
        right++;
    }
    return count;
}

int countSubstrings(char * s) {
    int s_len = strlen(s);
    if (s_len == 0) {
        return 0;
    }

    int total_palindromes = 0;

    for (int i = 0; i < s_len; i++) {
        total_palindromes += expandAndCount(s, i, i, s_len);
        total_palindromes += expandAndCount(s, i, i + 1, s_len);
    }

    return total_palindromes;
}
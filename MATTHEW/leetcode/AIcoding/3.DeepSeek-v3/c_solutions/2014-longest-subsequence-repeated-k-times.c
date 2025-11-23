#include <string.h>

int check(char* s, char* sub, int k) {
    int n = strlen(s);
    int m = strlen(sub);
    int cnt = 0;
    int j = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == sub[j]) {
            j++;
            if (j == m) {
                cnt++;
                j = 0;
                if (cnt == k) return 1;
            }
        }
    }
    return 0;
}

char* longestSubsequenceRepeatedK(char* s, int k) {
    static char res[8];
    static char temp[8];
    int n = strlen(s);
    int freq[26] = {0};

    for (int i = 0; i < n; i++) {
        freq[s[i] - 'a']++;
    }

    int len = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] >= k) {
            temp[len++] = 'a' + i;
        }
    }

    res[0] = '\0';
    int maxLen = 0;

    for (int mask = 1; mask < (1 << len); mask++) {
        int subLen = 0;
        char sub[8] = {0};
        for (int i = 0; i < len; i++) {
            if (mask & (1 << i)) {
                sub[subLen++] = temp[i];
            }
        }

        if (subLen <= maxLen) continue;

        do {
            if (check(s, sub, k)) {
                if (subLen > maxLen || (subLen == maxLen && strcmp(sub, res) > 0)) {
                    maxLen = subLen;
                    strcpy(res, sub);
                }
            }
        } while (next_permutation(sub, sub + subLen));
    }

    return res;
}

// Helper function for permutations
int next_permutation(char* first, char* last) {
    if (first == last) return 0;
    char* i = last;
    if (first == --i) return 0;

    while (1) {
        char* i1 = i;
        if (*--i < *i1) {
            char* i2 = last;
            while (!(*i < *--i2));
            char temp = *i;
            *i = *i2;
            *i2 = temp;
            reverse(i1, last);
            return 1;
        }
        if (i == first) {
            reverse(first, last);
            return 0;
        }
    }
}

void reverse(char* first, char* last) {
    while ((first != last) && (first != --last)) {
        char temp = *first;
        *first = *last;
        *last = temp;
        ++first;
    }
}
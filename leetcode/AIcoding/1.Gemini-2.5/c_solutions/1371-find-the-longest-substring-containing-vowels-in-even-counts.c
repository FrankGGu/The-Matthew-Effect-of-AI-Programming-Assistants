#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int findTheLongestSubstring(char * s){
    int n = strlen(s);

    int first_occurrence[32]; 
    for (int i = 0; i < 32; ++i) {
        first_occurrence[i] = -2;
    }

    first_occurrence[0] = -1;

    int current_mask = 0;
    int max_len = 0;

    for (int i = 0; i < n; ++i) {
        char c = s[i];

        if (c == 'a') {
            current_mask ^= (1 << 0);
        } else if (c == 'e') {
            current_mask ^= (1 << 1);
        } else if (c == 'i') {
            current_mask ^= (1 << 2);
        } else if (c == 'o') {
            current_mask ^= (1 << 3);
        } else if (c == 'u') {
            current_mask ^= (1 << 4);
        }

        if (first_occurrence[current_mask] != -2) {
            max_len = max(max_len, i - first_occurrence[current_mask]);
        } else {
            first_occurrence[current_mask] = i;
        }
    }

    return max_len;
}
#include <string.h>

long long appealSum(char * s){
    int n = strlen(s);
    long long total_appeal = 0;
    int last_pos[26];
    for (int i = 0; i < 26; i++) {
        last_pos[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int char_idx = s[i] - 'a';
        long long prev_idx = last_pos[char_idx];

        long long left_count = i - prev_idx;
        long long right_count = n - i;

        total_appeal += left_count * right_count;

        last_pos[char_idx] = i;
    }

    return total_appeal;
}
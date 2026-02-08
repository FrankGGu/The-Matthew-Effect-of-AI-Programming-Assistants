#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCharacters(char * a, char * b){
    int count_a[26] = {0};
    int count_b[26] = {0};
    int len_a = strlen(a);
    int len_b = strlen(b);
    int max_a = 0;
    int max_b = 0;
    int ans = INT_MAX;

    for (int i = 0; i < len_a; i++) {
        count_a[a[i] - 'a']++;
        if (count_a[a[i] - 'a'] > max_a) {
            max_a = count_a[a[i] - 'a'];
        }
    }

    for (int i = 0; i < len_b; i++) {
        count_b[b[i] - 'a']++;
        if (count_b[b[i] - 'a'] > max_b) {
            max_b = count_b[b[i] - 'a'];
        }
    }

    ans = fmin(ans, len_a - max_a + len_b - max_b);

    for (int i = 0; i < 25; i++) {
        int sum_a = 0;
        int sum_b = 0;
        for (int j = i + 1; j < 26; j++) {
            sum_a += count_a[j];
            sum_b += count_b[j];
        }
        ans = fmin(ans, sum_a + len_b - sum_b);
    }

    for (int i = 0; i < 25; i++) {
        int sum_a = 0;
        int sum_b = 0;
        for (int j = i + 1; j < 26; j++) {
            sum_a += count_a[j];
            sum_b += count_b[j];
        }
        ans = fmin(ans, sum_b + len_a - sum_a);
    }

    return ans;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int freq[]) {
    int count = 0;
    int val = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            if (count == 0) {
                val = freq[i];
                count++;
            } else {
                if (freq[i] != val) {
                    return false;
                }
            }
        }
    }
    return true;
}

int solve(char *s, int start, int end) {
    int freq[26] = {0};
    for (int i = start; i <= end; i++) {
        freq[s[i] - 'a']++;
    }

    int nonZeroCount = 0;
    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            nonZeroCount++;
        }
    }

    if (nonZeroCount == 0) return 0;

    if (check(freq)) {
        return 1;
    }

    for (int i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            int tempFreq[26];
            memcpy(tempFreq, freq, sizeof(freq));
            tempFreq[i]--;
            if (check(tempFreq)) {
                return 1;
            }
        }
    }
    return 2;
}

int minPartitions(char *s) {
    int n = strlen(s);
    int ans = n;
    for (int i = 0; i < (1 << (n - 1)); i++) {
        int count = 0;
        int start = 0;
        for (int j = 0; j < n - 1; j++) {
            if ((i >> j) & 1) {
                count += solve(s, start, j);
                start = j + 1;
            }
        }
        count += solve(s, start, n - 1);
        ans = (ans > count) ? count : ans;
    }
    return ans;
}
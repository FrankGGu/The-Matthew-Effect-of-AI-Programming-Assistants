#include <stdio.h>
#include <stdlib.h>

int minOperations(char* s, int k) {
    int n = 0;
    while (s[n] != '\0') n++;

    int count[26] = {0};
    for (int i = 0; i < k; i++) {
        count[s[i] - 'a']++;
    }

    int res = 0;
    for (int i = 0; i < 26; i++) {
        if (count[i] > 0) res++;
    }

    for (int i = k; i < n; i++) {
        count[s[i - k] - 'a']--;
        count[s[i] - 'a']++;

        int current = 0;
        for (int j = 0; j < 26; j++) {
            if (count[j] > 0) current++;
        }
        res = (current < res) ? current : res;
    }

    return res;
}
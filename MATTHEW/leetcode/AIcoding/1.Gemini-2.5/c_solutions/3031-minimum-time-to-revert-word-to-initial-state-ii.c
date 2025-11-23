#include <string.h>
#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

void compute_lps(const char* pattern, int m, int* lps) {
    lps[0] = 0;
    int length = 0;
    int i = 1;
    while (i < m) {
        if (pattern[i] == pattern[length]) {
            length++;
            lps[i] = length;
            i++;
        } else {
            if (length != 0) {
                length = lps[length - 1];
            } else {
                lps[i] = 0;
                i++;
            }
        }
    }
}

int minimumTimeToRevertWord(char* word, int k) {
    int n = strlen(word);

    int* lps = (int*)malloc(sizeof(int) * n);

    compute_lps(word, n, lps);

    int actual_period;
    int border_length = lps[n - 1];

    if (n > 0 && (n - border_length > 0) && (n % (n - border_length) == 0)) {
        actual_period = n - border_length;
    } else {
        actual_period = n;
    }

    free(lps);

    return actual_period / gcd(actual_period, k);
}
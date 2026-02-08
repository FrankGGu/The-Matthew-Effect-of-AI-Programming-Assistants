#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve() {
    char str[100001];
    int k;
    scanf("%s %d", str, &k);

    int n = strlen(str);
    if (n % k != 0) {
        return 0;
    }

    int len = n / k;
    unsigned int hash_val = 0;
    for (int i = 0; i < len; i++) {
        hash_val = hash_val * 31 + str[i];
    }

    for (int i = 1; i < k; i++) {
        unsigned int current_hash = 0;
        for (int j = 0; j < len; j++) {
            current_hash = current_hash * 31 + str[i * len + j];
        }
        if (current_hash != hash_val) {
            return 0;
        }
    }

    return 1;
}
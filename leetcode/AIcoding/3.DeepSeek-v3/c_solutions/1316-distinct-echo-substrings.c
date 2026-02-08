#include <string.h>
#include <stdlib.h>

typedef unsigned long long ull;

int distinctEchoSubstrings(char* text) {
    int n = strlen(text);
    ull base = 131;
    ull *hash = (ull*)malloc((n + 1) * sizeof(ull));
    ull *pow = (ull*)malloc((n + 1) * sizeof(ull));
    hash[0] = 0;
    pow[0] = 1;

    for (int i = 1; i <= n; i++) {
        hash[i] = hash[i - 1] * base + text[i - 1];
        pow[i] = pow[i - 1] * base;
    }

    int *seen = (int*)calloc(20001, sizeof(int));
    int count = 0;

    for (int len = 1; len <= n / 2; len++) {
        for (int i = 0; i + 2 * len <= n; i++) {
            ull h1 = hash[i + len] - hash[i] * pow[len];
            ull h2 = hash[i + 2 * len] - hash[i + len] * pow[len];
            if (h1 == h2) {
                int idx = h1 % 20001;
                while (seen[idx] != 0 && seen[idx] != h1) {
                    idx = (idx + 1) % 20001;
                }
                if (seen[idx] == 0) {
                    seen[idx] = h1;
                    count++;
                }
            }
        }
    }

    free(hash);
    free(pow);
    free(seen);
    return count;
}
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findLexSmallestString(char* s, int a, int b, int* returnSize) {
    int n = strlen(s);
    *returnSize = n;
    int* res = (int*)malloc(n * sizeof(int));
    int* best = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        res[i] = s[i] - '0';
        best[i] = 9;
    }

    int gcd(int x, int y) {
        return y == 0 ? x : gcd(y, x % y);
    }

    int g = gcd(n, b);

    for (int start = 0; start < n; start += g) {
        for (int add1 = 0; add1 < 10; add1++) {
            for (int add2 = 0; add2 < 10; add2++) {
                int* temp = (int*)malloc(n * sizeof(int));
                for (int i = 0; i < n; i++) {
                    temp[i] = res[(start + i) % n];
                }

                for (int i = 1; i < n; i += 2) {
                    temp[i] = (temp[i] + add1 * a) % 10;
                }
                for (int i = 0; i < n; i += 2) {
                    temp[i] = (temp[i] + add2 * a) % 10;
                }

                int better = 0;
                for (int i = 0; i < n; i++) {
                    if (temp[i] < best[i]) {
                        better = 1;
                        break;
                    } else if (temp[i] > best[i]) {
                        break;
                    }
                }

                if (better) {
                    for (int i = 0; i < n; i++) {
                        best[i] = temp[i];
                    }
                }
                free(temp);
            }
        }
    }

    free(res);
    return best;
}
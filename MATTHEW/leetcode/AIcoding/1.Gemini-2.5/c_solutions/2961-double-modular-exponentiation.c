long long power(long long base, long long exp, long long mod) {
    if (mod == 1) {
        return 0;
    }
    long long res = 1;
    base %= mod;

    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int* getGoodIndices(int* base, int baseSize, int* exp, int expSize, int* mod, int modSize, int target, int* returnSize) {
    int* goodIndices = (int*) malloc(baseSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < baseSize; i++) {
        long long val1 = power(base[i], exp[i], mod[i]);
        long long val2 = val1 % 10;

        if (val2 == target) {
            goodIndices[count++] = i;
        }
    }

    if (count == 0) {
        free(goodIndices);
        *returnSize = 0;
        return NULL;
    } else {
        int* finalGoodIndices = (int*) realloc(goodIndices, count * sizeof(int));
        if (finalGoodIndices == NULL) {
            *returnSize = count;
            return goodIndices;
        } else {
            *returnSize = count;
            return finalGoodIndices;
        }
    }
}
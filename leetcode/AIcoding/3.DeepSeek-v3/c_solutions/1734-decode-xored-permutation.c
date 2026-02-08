/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* decode(int* encoded, int encodedSize, int* returnSize) {
    int n = encodedSize + 1;
    int* perm = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int total_xor = 0;
    for (int i = 1; i <= n; i++) {
        total_xor ^= i;
    }

    int odd_xor = 0;
    for (int i = 1; i < encodedSize; i += 2) {
        odd_xor ^= encoded[i];
    }

    perm[0] = total_xor ^ odd_xor;

    for (int i = 1; i < n; i++) {
        perm[i] = perm[i - 1] ^ encoded[i - 1];
    }

    return perm;
}
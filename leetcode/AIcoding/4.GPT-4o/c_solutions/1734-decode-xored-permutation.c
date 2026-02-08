int* decode(int* encoded, int encodedSize, int* returnSize) {
    int n = encodedSize + 1;
    int* perm = (int*)malloc(n * sizeof(int));
    int totalXOR = 0;
    for (int i = 1; i <= n; i++) {
        totalXOR ^= i;
    }
    int oddXOR = 0;
    for (int i = 1; i < encodedSize; i += 2) {
        oddXOR ^= encoded[i];
    }
    perm[0] = totalXOR ^ oddXOR;
    for (int i = 0; i < encodedSize; i++) {
        perm[i + 1] = perm[i] ^ encoded[i];
    }
    *returnSize = n;
    return perm;
}
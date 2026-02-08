int* decode(int* encoded, int encodedSize, int first, int* returnSize) {
    *returnSize = encodedSize + 1;
    int* decoded = (int*)malloc((*returnSize) * sizeof(int));
    decoded[0] = first;
    for (int i = 1; i < *returnSize; i++) {
        decoded[i] = decoded[i - 1] ^ encoded[i - 1];
    }
    return decoded;
}
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sockCollocation(int* sockets, int socketsSize, int* returnSize) {
    int xor_all = 0;
    for (int i = 0; i < socketsSize; i++) {
        xor_all ^= sockets[i];
    }

    int diff_bit = xor_all & (-xor_all);

    int a = 0, b = 0;
    for (int i = 0; i < socketsSize; i++) {
        if (sockets[i] & diff_bit) {
            a ^= sockets[i];
        } else {
            b ^= sockets[i];
        }
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = a;
    result[1] = b;
    return result;
}
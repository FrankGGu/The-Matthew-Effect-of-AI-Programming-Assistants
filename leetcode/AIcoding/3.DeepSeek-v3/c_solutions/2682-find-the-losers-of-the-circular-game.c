/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* circularGameLosers(int n, int k, int* returnSize) {
    int* received = (int*)calloc(n, sizeof(int));
    int pos = 0;
    int step = 1;

    while (1) {
        if (received[pos]) {
            break;
        }
        received[pos] = 1;
        pos = (pos + step * k) % n;
        step++;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        if (!received[i]) {
            count++;
        }
    }

    *returnSize = count;
    int* losers = (int*)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < n; i++) {
        if (!received[i]) {
            losers[idx++] = i + 1;
        }
    }

    free(received);
    return losers;
}
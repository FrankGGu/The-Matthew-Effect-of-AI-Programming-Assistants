#define MAXN 100000

int shortestSubarray(int* A, int ASize, int K) {
    long long prefix[MAXN + 1];
    int minLen = ASize + 1;
    int deque[MAXN + 1];
    int front = 0, back = 0;

    prefix[0] = 0;
    for (int i = 0; i < ASize; i++) {
        prefix[i + 1] = prefix[i] | A[i];
    }

    for (int i = 0; i <= ASize; i++) {
        while (front < back && prefix[deque[back - 1]] >= prefix[i]) {
            back--;
        }
        deque[back++] = i;

        while (front < back && (prefix[i] & prefix[deque[front]]) < K) {
            minLen = (minLen < i - deque[front] ? minLen : i - deque[front]);
            front++;
        }
    }

    return minLen == ASize + 1 ? -1 : minLen;
}
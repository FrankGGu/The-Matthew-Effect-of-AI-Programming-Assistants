#define MAX_N 100000
#define LOG 17

long long maxWeight[100000][17];
int nextNode[100000][17];

long long getMaxFunctionValue(int* receiver, int receiverSize, long long k) {
    int n = receiverSize;
    for (int i = 0; i < n; i++) {
        nextNode[i][0] = receiver[i];
        maxWeight[i][0] = receiver[i];
    }

    for (int j = 1; j < LOG; j++) {
        for (int i = 0; i < n; i++) {
            int mid = nextNode[i][j-1];
            nextNode[i][j] = nextNode[mid][j-1];
            maxWeight[i][j] = maxWeight[i][j-1] + maxWeight[mid][j-1];
        }
    }

    long long res = 0;
    for (int i = 0; i < n; i++) {
        long long cur = i;
        int pos = i;
        for (int j = 0; j < LOG; j++) {
            if (k & (1LL << j)) {
                cur += maxWeight[pos][j];
                pos = nextNode[pos][j];
            }
        }
        if (cur > res) res = cur;
    }
    return res;
}
int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

void dfs(int firstPlayer, int secondPlayer, int round, int n, int *minRound, int *maxRound) {
    if (firstPlayer > secondPlayer) {
        int temp = firstPlayer;
        firstPlayer = secondPlayer;
        secondPlayer = temp;
    }

    if (firstPlayer == secondPlayer) {
        return;
    }

    if (firstPlayer + secondPlayer == n + 1) {
        *minRound = (*minRound < round) ? *minRound : round;
        *maxRound = (*maxRound > round) ? *maxRound : round;
        return;
    }

    int half = (n + 1) / 2;
    int newFirst, newSecond;

    if (firstPlayer <= half && secondPlayer <= half) {
        newFirst = firstPlayer;
        newSecond = secondPlayer;
        dfs(newFirst, newSecond, round + 1, half, minRound, maxRound);
    } else if (firstPlayer <= half && secondPlayer > half) {
        int newSecondPos = n + 1 - secondPlayer;
        if (newSecondPos < firstPlayer) {
            newFirst = newSecondPos;
            newSecond = firstPlayer;
        } else {
            newFirst = firstPlayer;
            newSecond = newSecondPos;
        }
        dfs(newFirst, newSecond, round + 1, half, minRound, maxRound);
    } else {
        int newFirstPos = n + 1 - firstPlayer;
        int newSecondPos = n + 1 - secondPlayer;
        newFirst = (newFirstPos < newSecondPos) ? newFirstPos : newSecondPos;
        newSecond = (newFirstPos < newSecondPos) ? newSecondPos : newFirstPos;
        dfs(newFirst, newSecond, round + 1, half, minRound, maxRound);
    }
}

int* earliestAndLatest(int n, int firstPlayer, int secondPlayer, int* returnSize) {
    int *result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    result[0] = n;
    result[1] = 1;

    dfs(firstPlayer, secondPlayer, 1, n, &result[0], &result[1]);

    return result;
}
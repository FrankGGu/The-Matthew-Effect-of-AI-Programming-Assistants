int findMinStep(char *board, char *hand) {
    int handCount[26] = {0};
    for (int i = 0; hand[i]; i++) {
        handCount[hand[i] - 'A']++;
    }

    int n = strlen(board);
    int result = helper(board, handCount);
    return result == INT_MAX ? -1 : result;
}

int helper(char *board, int *handCount) {
    int n = strlen(board);
    if (n == 0) return 0;

    char newBoard[30];
    int minSteps = INT_MAX;

    for (int i = 0; i < n; ) {
        int j = i;
        while (j < n && board[j] == board[i]) {
            j++;
        }

        int need = 3 - (j - i);
        if (need <= 0) {
            minSteps = min(minSteps, helper(substring(board, 0, i) + substring(board, j, n), handCount));
        } else if (handCount[board[i] - 'A'] >= need) {
            handCount[board[i] - 'A'] -= need;
            minSteps = min(minSteps, need + helper(substring(board, 0, i) + substring(board, j, n), handCount));
            handCount[board[i] - 'A'] += need;
        }

        i = j;
    }

    return minSteps;
}

char* substring(char *s, int start, int end) {
    char *result = (char *)malloc(sizeof(char) * (end - start + 1));
    strncpy(result, s + start, end - start);
    result[end - start] = '\0';
    return result;
}
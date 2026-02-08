int findMinStep(char* board, char* hand) {
    int handCount[26] = {0};
    for (int i = 0; hand[i]; i++) {
        handCount[hand[i] - 'A']++;
    }

    int result = dfs(board, handCount);
    return result == INT_MAX ? -1 : result;
}

int dfs(char* board, int* handCount) {
    if (*board == '\0') return 0;

    int res = INT_MAX;
    char* p = board;
    char* q = board;

    while (*p) {
        while (*q && *q == *p) {
            q++;
        }

        int color = *p - 'A';
        int need = 3 - (q - p);
        if (handCount[color] >= need) {
            handCount[color] -= need;
            char newBoard[100];
            strcpy(newBoard, board);
            removeBalls(newBoard, p - board, q - board);
            int temp = dfs(newBoard, handCount);
            if (temp != INT_MAX) {
                res = res < temp + need ? res : temp + need;
            }
            handCount[color] += need;
        }
        p = q;
    }

    return res;
}

void removeBalls(char* board, int start, int end) {
    int len = strlen(board);
    memmove(board + start, board + end, len - end + 1);

    while (eliminate(board)) {
        // Continue eliminating until no more eliminations possible
    }
}

int eliminate(char* board) {
    char* p = board;
    char* q = board;
    int eliminated = 0;

    while (*p) {
        q = p;
        while (*q && *q == *p) {
            q++;
        }
        if (q - p >= 3) {
            memmove(p, q, strlen(q) + 1);
            eliminated = 1;
            break;
        }
        p = q;
    }

    return eliminated;
}
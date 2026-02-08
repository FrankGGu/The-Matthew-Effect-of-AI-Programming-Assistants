/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* executeInstructions(int n, int* startPos, int startPosSize, char* s, int* returnSize) {
    int m = strlen(s);
    *returnSize = m;
    int* result = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < m; i++) {
        int x = startPos[0];
        int y = startPos[1];
        int count = 0;

        for (int j = i; j < m; j++) {
            char move = s[j];
            if (move == 'L') y--;
            else if (move == 'R') y++;
            else if (move == 'U') x--;
            else if (move == 'D') x++;

            if (x < 0 || x >= n || y < 0 || y >= n) {
                break;
            }
            count++;
        }

        result[i] = count;
    }

    return result;
}
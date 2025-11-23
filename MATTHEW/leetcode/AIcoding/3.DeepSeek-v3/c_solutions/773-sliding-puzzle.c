int slidingPuzzle(int** board, int boardSize, int* boardColSize) {
    int target = 123450;
    int start = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            start = start * 10 + board[i][j];
        }
    }

    if (start == target) return 0;

    int moves[6][4] = {
        {1, 3, -1, -1},
        {0, 2, 4, -1},
        {1, 5, -1, -1},
        {0, 4, -1, -1},
        {1, 3, 5, -1},
        {2, 4, -1, -1}
    };

    int visited[543211] = {0};
    int queue[100000];
    int front = 0, rear = 0;
    queue[rear++] = start;
    visited[start] = 1;

    int step = 0;
    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int state = queue[front++];
            if (state == target) return step;

            int pos = 0;
            int temp = state;
            for (int j = 5; j >= 0; j--) {
                if (temp % 10 == 0) {
                    pos = j;
                    break;
                }
                temp /= 10;
            }

            int digits[6];
            temp = state;
            for (int j = 5; j >= 0; j--) {
                digits[j] = temp % 10;
                temp /= 10;
            }

            for (int j = 0; j < 4; j++) {
                int new_pos = moves[pos][j];
                if (new_pos == -1) break;

                int new_digits[6];
                for (int k = 0; k < 6; k++) {
                    new_digits[k] = digits[k];
                }

                new_digits[pos] = new_digits[new_pos];
                new_digits[new_pos] = 0;

                int new_state = 0;
                for (int k = 0; k < 6; k++) {
                    new_state = new_state * 10 + new_digits[k];
                }

                if (!visited[new_state]) {
                    visited[new_state] = 1;
                    queue[rear++] = new_state;
                }
            }
        }
        step++;
    }

    return -1;
}
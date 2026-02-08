int numOfMessages(int n, int k, int row, int col) {
    if (row < 0 || row >= n || col < 0 || col >= n) return 0;
    if (k == 0) return 1;

    int count = 0;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    for (int i = 0; i < 4; i++) {
        int newRow = row + directions[i][0];
        int newCol = col + directions[i][1];
        count += numOfMessages(n, k - 1, newRow, newCol);
    }

    return count;
}

int numOfMessagesWrapper(int n, int k, int row, int col) {
    return numOfMessages(n, k, row, col);
}
int minMoves(int* arr, int arrSize, int k) {
    long long total = 0;
    for (int i = 0; i < arrSize; i++) {
        total += arr[i];
    }

    long long target = total / arrSize;
    long long moves = 0;

    for (int i = 0; i < arrSize; i++) {
        moves += abs(arr[i] - target);
    }

    return moves / 2;
}
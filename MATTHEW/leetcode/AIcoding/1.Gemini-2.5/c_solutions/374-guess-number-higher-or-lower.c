extern int guess(int num);

int guessNumber(int n) {
    int low = 1;
    int high = n;
    int mid;
    int res;

    while (low <= high) {
        mid = low + (high - low) / 2;
        res = guess(mid);

        if (res == 0) {
            return mid;
        } else if (res == -1) { // My number is lower than mid
            high = mid - 1;
        } else { // res == 1, My number is higher than mid
            low = mid + 1;
        }
    }
    return -1; // Should not reach here in a valid problem scenario
}
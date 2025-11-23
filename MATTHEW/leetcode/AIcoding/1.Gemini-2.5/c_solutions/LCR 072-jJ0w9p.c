int mySqrt(int x) {
    if (x == 0) {
        return 0;
    }

    int left = 1;
    int right = x;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        // Use long long to prevent overflow when calculating mid*mid
        long long square = (long long)mid * mid;

        if (square == x) {
            return mid;
        } else if (square < x) {
            ans = mid; // mid could be the answer, try a larger one
            left = mid + 1;
        } else {
            right = mid - 1; // mid is too large, try a smaller one
        }
    }

    return ans;
}
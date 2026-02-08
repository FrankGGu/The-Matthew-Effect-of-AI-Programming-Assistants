int sumOfNumbersWithUnitsDigitK(int num, int k) {
    if (num == 0) {
        return 0;
    }

    // Special handling for k=0
    // If k=0, numbers must have units digit 0 (e.g., 10, 20, 30...).
    // Their sum must also have units digit 0.
    // If num has units digit 0, we can use num itself (if num > 0) as one number.
    // If num has units digit 0 and num > 0, the minimum count is 1.
    // If num has units digit not 0, it's impossible.
    // num=0 is already handled.
    if (k == 0) {
        if (num % 10 == 0) {
            return 1;
        } else {
            return -1;
        }
    }

    // For k > 0
    // We are looking for the minimum number of positive integers (m)
    // each having units digit k, that sum up to num.
    // Let these numbers be n_1, n_2, ..., n_m.
    // Each n_i can be written as 10*x_i + k, where x_i >= 0 (since n_i >= k > 0).
    // Sum = (10*x_1 + k) + ... + (10*x_m + k)
    // Sum = 10 * (x_1 + ... + x_m) + m * k = num
    // Let X = x_1 + ... + x_m.
    // So, 10 * X + m * k = num.
    // This implies two conditions for a valid m:
    // 1. num - m * k must be non-negative (since 10*X >= 0, as X >= 0).
    // 2. num - m * k must be a multiple of 10 (since 10*X is a multiple of 10).
    // We iterate m from 1 upwards to find the minimum such m.
    // The maximum possible value for m is num (e.g., if k=1, num=100, we could use 100 ones).
    for (int m = 1; m <= num; m++) {
        int remaining_sum = num - m * k;
        if (remaining_sum >= 0 && remaining_sum % 10 == 0) {
            return m;
        }
    }

    // If no such m is found after checking all possibilities up to num.
    return -1;
}
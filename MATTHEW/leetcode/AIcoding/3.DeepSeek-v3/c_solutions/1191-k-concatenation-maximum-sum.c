int kConcatenationMaxSum(int* arr, int arrSize, int k) {
    long long mod = 1e9 + 7;
    long long total_sum = 0;
    long long max_prefix = 0, max_suffix = 0;
    long long current_prefix = 0, current_suffix = 0;

    for (int i = 0; i < arrSize; i++) {
        total_sum += arr[i];
        current_prefix += arr[i];
        if (current_prefix > max_prefix) {
            max_prefix = current_prefix;
        }
    }

    for (int i = arrSize - 1; i >= 0; i--) {
        current_suffix += arr[i];
        if (current_suffix > max_suffix) {
            max_suffix = current_suffix;
        }
    }

    long long max_ending_here = 0;
    long long max_so_far = 0;
    for (int i = 0; i < arrSize; i++) {
        max_ending_here = (max_ending_here + arr[i] > 0) ? max_ending_here + arr[i] : 0;
        if (max_ending_here > max_so_far) {
            max_so_far = max_ending_here;
        }
    }

    if (k == 1) {
        return max_so_far % mod;
    }

    long long candidate1 = max_so_far;
    long long candidate2 = max_prefix + max_suffix;
    long long candidate3 = max_prefix + max_suffix + (k - 2) * total_sum;

    long long result = candidate1 > candidate2 ? candidate1 : candidate2;
    if (total_sum > 0 && candidate3 > result) {
        result = candidate3;
    }

    if (result < 0) {
        return 0;
    }
    return result % mod;
}
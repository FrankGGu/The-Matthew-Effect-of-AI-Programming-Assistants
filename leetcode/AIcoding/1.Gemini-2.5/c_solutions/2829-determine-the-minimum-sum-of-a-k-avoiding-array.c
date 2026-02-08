long long minimumSum(int n, int k) {
    long long count_small = (k - 1) / 2;
    long long total_sum = 0;

    if (n <= count_small) {
        // If n is small enough, we just pick 1, 2, ..., n.
        // These numbers are all less than k/2, so no two distinct elements x, y
        // will sum to k.
        total_sum = (long long)n * (n + 1) / 2;
    } else {
        // First, pick all numbers from 1 up to count_small.
        // These are count_small numbers, and they are all < k/2.
        total_sum = count_small * (count_small + 1) / 2;
        long long remaining_n = n - count_small;

        long long start_val_for_remaining;

        // Determine the next smallest available number to pick after 1, ..., count_small.
        // This depends on whether k is even or odd.
        if (k % 2 == 0) {
            // If k is even, count_small = k/2 - 1.
            // The number k/2 is not in {1, ..., k/2 - 1}.
            // And k/2 + k/2 = k, but we only pick it once, so it doesn't violate "distinct elements".
            // So, k/2 is the next smallest available number.
            total_sum += k / 2;
            remaining_n--;

            // After picking k/2, the numbers from k/2 + 1 up to k-1 are forbidden
            // because their complements (k - (k/2+1) = k/2-1, etc.) are in {1, ..., k/2-1}.
            // So, the next available number after k/2 is k.
            start_val_for_remaining = k;
        } else {
            // If k is odd, count_small = (k-1)/2.
            // The number (k-1)/2 + 1 = (k+1)/2.
            // This number is exactly k - (k-1)/2, so its complement (k-1)/2 is already picked.
            // Thus, (k+1)/2 is forbidden.
            // All numbers from (k+1)/2 up to k-1 are forbidden for similar reasons.
            // So, the next available number is k.
            start_val_for_remaining = k;
        }

        // Add the remaining_n numbers, starting from start_val_for_remaining.
        if (remaining_n > 0) {
            long long end_val_for_remaining = start_val_for_remaining + remaining_n - 1;
            total_sum += remaining_n * (start_val_for_remaining + end_val_for_remaining) / 2;
        }
    }

    return total_sum;
}
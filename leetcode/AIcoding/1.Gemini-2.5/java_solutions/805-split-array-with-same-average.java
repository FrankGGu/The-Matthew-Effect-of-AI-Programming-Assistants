import java.util.*;

class Solution {
    public boolean splitArraySameAverage(int[] nums) {
        int n = nums.length;
        if (n == 1) {
            return false; // Cannot split into two non-empty arrays
        }

        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        // We are looking for a sub-array A of length k and sum s_A such that s_A / k == totalSum / n.
        // This implies s_A * n == totalSum * k.
        // Also, 1 <= k < n, as both sub-arrays A and B must be non-empty.
        // If A has length k, B has length n-k. Since A and B are non-empty, 1 <= k <= n-1.

        // Meet-in-the-middle approach
        int mid = n / 2;

        // left_sums[k] stores all possible sums using k elements from nums[0...mid-1]
        // The size of left_sums is mid + 1, as k can range from 0 to mid.
        List<Set<Integer>> left_sums = new ArrayList<>();
        for (int i = 0; i <= mid; i++) {
            left_sums.add(new HashSet<>());
        }
        left_sums.get(0).add(0); // Base case: 0 elements sum to 0

        // Populate left_sums
        for (int i = 0; i < mid; i++) { // Iterate through elements in the left half
            int num = nums[i];
            // Iterate k downwards to ensure each element is used at most once for a given sum
            // k represents the number of elements already processed from nums[0...i-1]
            // The maximum number of elements we could have picked from nums[0...i-1] is i.
            for (int k = i; k >= 0; k--) { 
                if (!left_sums.get(k).isEmpty()) {
                    for (int prev_sum : left_sums.get(k)) {
                        left_sums.get(k + 1).add(prev_sum + num);
                    }
                }
            }
        }

        // right_sums[k] stores all possible sums using k elements from nums[mid...n-1]
        // The size of right_sums is (n - mid) + 1, as k can range from 0 to n - mid.
        List<Set<Integer>> right_sums = new ArrayList<>();
        for (int i = 0; i <= n - mid; i++) {
            right_sums.add(new HashSet<>());
        }
        right_sums.get(0).add(0); // Base case: 0 elements sum to 0

        // Populate right_sums
        for (int i = mid; i < n; i++) { // Iterate through elements in the right half
            int num = nums[i];
            // k represents the number of elements already processed from nums[mid...i-1]
            // The maximum number of elements we could have picked from nums[mid...i-1] is i - mid.
            for (int k = i - mid; k >= 0; k--) { 
                if (!right_sums.get(k).isEmpty()) {
                    for (int prev_sum : right_sums.get(k)) {
                        right_sums.get(k + 1).add(prev_sum + num);
                    }
                }
            }
        }

        // Iterate through all possible lengths k for sub-array A (1 <= k < n)
        for (int k = 1; k < n; k++) {
            // Check if totalSum * k is divisible by n. If not, target_sum_A would not be an integer.
            if ((totalSum * k) % n != 0) {
                continue;
            }

            int target_sum_A = (totalSum * k) / n;

            // Try to form target_sum_A with k elements using combinations from left and right halves
            // k_L: number of elements from left half
            // k_R: number of elements from right half
            // k_L + k_R = k
            // k_L ranges from 0 to mid (max elements in left half)
            // k_R ranges from 0 to n-mid (max elements in right half)
            for (int k_L = 0; k_L <= mid; k_L++) {
                // If k_L is already greater than the total target length k, skip
                if (k_L > k) {
                    continue;
                }

                int k_R = k - k_L;

                // k_R must be within valid range for right_sums
                if (k_R < 0 || k_R > (n - mid)) {
                    continue;
                }

                // If left_sums.get(k_L) is empty, no sums possible with k_L elements from left half
                if (left_sums.get(k_L).isEmpty()) {
                    continue;
                }

                for (int s_L : left_sums.get(k_L)) {
                    int s_R = target_sum_A - s_L;
                    // Check if s_R can be formed using k_R elements from the right half
                    if (right_sums.get(k_R).contains(s_R)) {
                        return true;
                    }
                }
            }
        }

        return false;
    }
}
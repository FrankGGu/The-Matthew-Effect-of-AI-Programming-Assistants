class Solution {
    public long maxScore(int[] nums, int x) {
        long dp_even = Long.MIN_VALUE;
        long dp_odd = Long.MIN_VALUE;

        // Initialize based on the first element
        if (nums[0] % 2 == 0) {
            dp_even = nums[0];
        } else {
            dp_odd = nums[0];
        }

        // Iterate from the second element
        for (int i = 1; i < nums.length; i++) {
            long currentNum = nums[i];

            long prev_dp_even = dp_even; // Store previous values before potential update
            long prev_dp_odd = dp_odd;

            if (currentNum % 2 == 0) { // Current number is even
                // Option 1: Extend an existing even path (no penalty)
                long scoreFromEvenPath = (prev_dp_even == Long.MIN_VALUE) ? Long.MIN_VALUE : prev_dp_even + currentNum;
                // Option 2: Extend an existing odd path (with penalty)
                long scoreFromOddPath = (prev_dp_odd == Long.MIN_VALUE) ? Long.MIN_VALUE : prev_dp_odd + currentNum - x;

                // Update dp_even with the maximum of these two candidates.
                // If both candidates are Long.MIN_VALUE, dp_even remains Long.MIN_VALUE.
                dp_even = Math.max(scoreFromEvenPath, scoreFromOddPath);
                // dp_odd remains unchanged as currentNum is even.
            } else { // Current number is odd
                // Option 1: Extend an existing odd path (no penalty)
                long scoreFromOddPath = (prev_dp_odd == Long.MIN_VALUE) ? Long.MIN_VALUE : prev_dp_odd + currentNum;
                // Option 2: Extend an existing even path (with penalty)
                long scoreFromEvenPath = (prev_dp_even == Long.MIN_VALUE) ? Long.MIN_VALUE : prev_dp_even + currentNum - x;

                // Update dp_odd with the maximum of these two candidates.
                dp_odd = Math.max(scoreFromOddPath, scoreFromEvenPath);
                // dp_even remains unchanged as currentNum is odd.
            }
        }

        // The maximum score can be either ending with an even number or an odd number
        return Math.max(dp_even, dp_odd);
    }
}
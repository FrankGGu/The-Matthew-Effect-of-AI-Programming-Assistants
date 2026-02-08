class Solution {
    public int minimumPartition(String s, int k) {
        int count = 1;
        long currentValue = 0L;

        for (int i = 0; i < s.length(); i++) {
            int digit = s.charAt(i) - '0';

            // If a single digit itself is greater than k, it's impossible to partition.
            // Given constraints (k >= 1, digits 0-9), this condition will only be true
            // if k is very small, e.g., k=0 (not allowed) or k=1 and digit is 2.
            // However, for k >= 1, any single digit 0-9 will be <= k.
            // The problem statement implies a solution always exists or doesn't specify -1.
            // If this were a real possibility, the problem would specify return -1.
            // For example, if s = "7", k = 5, then 7 > 5, impossible.
            // But for Leetcode, constraints usually ensure such simple cases are handled
            // by the main logic or are not test cases.
            // The existing logic implicitly handles this:
            // if digit > k, then currentValue * 10 + digit will definitely be > k (or digit itself if currentValue is 0).
            // So, a new partition will start with 'digit', and if 'digit' > k, it will be the 'currentValue'
            // for the next iteration, and if it's still > k, it's an issue.
            // Let's test this: s="7", k=5
            // count=1, currentValue=0
            // i=0, digit=7. nextValue = 0*10+7 = 7. 7 > 5.
            //   count=2. currentValue=7.
            // Loop ends. Return 2. This is incorrect. It should be impossible.
            // So, a direct check for single digit is needed.

            if (digit > k) {
                return -1; // Impossible to form a partition if a single digit exceeds k
            }

            long nextValue = currentValue * 10 + digit;

            if (nextValue > k) {
                // The current partition (currentValue) is complete.
                // Start a new partition with the current digit.
                count++;
                currentValue = digit; 
            } else {
                // Continue building the current partition.
                currentValue = nextValue;
            }
        }

        return count;
    }
}
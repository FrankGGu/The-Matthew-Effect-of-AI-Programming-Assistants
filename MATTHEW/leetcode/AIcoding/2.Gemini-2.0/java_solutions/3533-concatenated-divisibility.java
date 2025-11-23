class Solution {
    public int solve(int[] nums) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < nums.length; j++) {
                if (i != j) {
                    String concatenated = String.valueOf(nums[i]) + String.valueOf(nums[j]);
                    try {
                        long num = Long.parseLong(concatenated);
                        if (num % 11 == 0) {
                            count++;
                        }
                    } catch (NumberFormatException e) {
                        // Handle potential NumberFormatException if concatenation results in a very large number
                        // In this case, it's unlikely to be divisible by 11 anyway.
                    }
                }
            }
        }
        return count;
    }
}
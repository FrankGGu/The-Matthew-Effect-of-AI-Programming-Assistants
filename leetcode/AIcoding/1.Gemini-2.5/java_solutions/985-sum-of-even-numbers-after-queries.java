class Solution {
    public int[] sumEvenAfterQueries(int[] nums, int[][] queries) {
        int currentEvenSum = 0;
        for (int num : nums) {
            if (num % 2 == 0) {
                currentEvenSum += num;
            }
        }

        int[] result = new int[queries.length];

        for (int i = 0; i < queries.length; i++) {
            int val = queries[i][0];
            int index = queries[i][1];

            // If the number at index was even, subtract it from currentEvenSum
            if (nums[index] % 2 == 0) {
                currentEvenSum -= nums[index];
            }

            // Update the number
            nums[index] += val;

            // If the new number at index is even, add it to currentEvenSum
            if (nums[index] % 2 == 0) {
                currentEvenSum += nums[index];
            }

            result[i] = currentEvenSum;
        }

        return result;
    }
}
class Solution {
    public int maximumOperations(int[] nums) {
        int countOnes = 0;
        int operations = 0;

        for (int num : nums) {
            if (num == 1) {
                countOnes++;
            } else {
                operations += countOnes;
            }
        }

        return operations;
    }
}
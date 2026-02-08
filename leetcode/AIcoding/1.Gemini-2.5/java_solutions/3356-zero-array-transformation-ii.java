class Solution {
    public long minimumOperations(int[] nums) {
        long operations = 0;
        int currentHeight = 0;

        for (int num : nums) {
            if (num > currentHeight) {
                operations += (num - currentHeight);
            }
            currentHeight = num;
        }

        return operations;
    }
}
class Solution {
    public int differenceOfSums(int[] nums, int k) {
        int divisibleSum = 0;
        int nonDivisibleSum = 0;

        for (int num : nums) {
            if (num % k == 0) {
                divisibleSum += num;
            } else {
                nonDivisibleSum += num;
            }
        }

        return divisibleSum - nonDivisibleSum;
    }
}
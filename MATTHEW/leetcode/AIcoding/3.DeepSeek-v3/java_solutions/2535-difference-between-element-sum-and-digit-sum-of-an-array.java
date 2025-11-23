class Solution {
    public int differenceOfSum(int[] nums) {
        int elementSum = 0;
        int digitSum = 0;

        for (int num : nums) {
            elementSum += num;
            int current = num;
            while (current > 0) {
                digitSum += current % 10;
                current /= 10;
            }
        }

        return Math.abs(elementSum - digitSum);
    }
}
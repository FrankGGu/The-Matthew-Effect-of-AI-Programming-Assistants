public class Solution {
    public int differenceBetweenElementSumAndDigitSum(int[] nums) {
        int elementSum = 0;
        int digitSum = 0;

        for (int num : nums) {
            elementSum += num;
            int temp = num;
            while (temp > 0) {
                digitSum += temp % 10;
                temp /= 10;
            }
        }

        return elementSum - digitSum;
    }
}
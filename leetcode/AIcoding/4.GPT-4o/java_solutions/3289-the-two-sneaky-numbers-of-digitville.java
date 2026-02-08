class Solution {
    public int[] missingTwo(int[] nums) {
        int n = nums.length + 2;
        int totalSum = n * (n + 1) / 2;
        int numsSum = 0;
        for (int num : nums) {
            numsSum += num;
        }
        int sumOfTwo = totalSum - numsSum;
        int pivot = sumOfTwo / 2;

        int totalLeftSum = pivot * (pivot + 1) / 2;
        int leftSum = 0;
        for (int num : nums) {
            if (num <= pivot) {
                leftSum += num;
            }
        }

        int first = totalLeftSum - leftSum;
        int second = sumOfTwo - first;

        return new int[] {first, second};
    }
}
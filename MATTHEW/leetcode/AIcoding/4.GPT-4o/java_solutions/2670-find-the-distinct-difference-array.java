class Solution {
    public int[] distinctDifferenceArray(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int[] leftCount = new int[101];
        int[] rightCount = new int[101];

        for (int num : nums) {
            rightCount[num]++;
        }

        for (int i = 0; i < n; i++) {
            leftCount[nums[i]]++;
            rightCount[nums[i]]--;

            int leftDistinct = 0;
            int rightDistinct = 0;

            for (int j = 0; j < 101; j++) {
                if (leftCount[j] > 0) {
                    leftDistinct++;
                }
                if (rightCount[j] > 0) {
                    rightDistinct++;
                }
            }

            result[i] = leftDistinct - rightDistinct;
        }

        return result;
    }
}
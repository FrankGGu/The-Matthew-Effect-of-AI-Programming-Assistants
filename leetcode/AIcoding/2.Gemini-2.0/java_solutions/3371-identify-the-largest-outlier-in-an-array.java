class Solution {
    public int findLargestOutlier(int[] nums) {
        if (nums == null || nums.length < 3) {
            return -1;
        }

        int[] sortedNums = nums.clone();
        java.util.Arrays.sort(sortedNums);

        int iqr = sortedNums[sortedNums.length * 3 / 4] - sortedNums[sortedNums.length / 4];
        int lowerBound = sortedNums[sortedNums.length / 4] - 3 * iqr;
        int upperBound = sortedNums[sortedNums.length * 3 / 4] + 3 * iqr;

        int largestOutlier = -1;
        for (int num : nums) {
            if (num < lowerBound || num > upperBound) {
                if (largestOutlier == -1 || Math.abs(num) > Math.abs(largestOutlier)) {
                    largestOutlier = num;
                }
            }
        }

        return largestOutlier;
    }
}
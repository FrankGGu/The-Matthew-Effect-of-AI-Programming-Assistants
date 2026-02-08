class Solution {
    public int maximumDifference(int[] nums) {
        int maxEven = Integer.MIN_VALUE;
        int minOdd = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num % 2 == 0) {
                maxEven = Math.max(maxEven, num);
            } else {
                minOdd = Math.min(minOdd, num);
            }
        }

        return maxEven - minOdd > 0 ? maxEven - minOdd : -1;
    }
}
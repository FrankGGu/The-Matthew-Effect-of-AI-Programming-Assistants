class Solution {
    public int maxSequenceValue(int[] arr) {
        int max = Integer.MIN_VALUE;
        int currentSum = 0;

        for (int num : arr) {
            currentSum = Math.max(num, currentSum + num);
            max = Math.max(max, currentSum);
        }

        return max > 0 ? max : 0;
    }
}
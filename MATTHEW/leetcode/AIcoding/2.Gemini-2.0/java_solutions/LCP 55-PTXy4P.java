class Solution {
    public int maxTotalFruits(int[][] fruits, int startPos, int k) {
        int n = fruits.length;
        int left = 0;
        int right = 0;
        int currSum = 0;
        int maxFruits = 0;

        while (right < n) {
            currSum += fruits[right][1];

            while (left <= right && !isValid(fruits, startPos, fruits[left][0], fruits[right][0], k)) {
                currSum -= fruits[left][1];
                left++;
            }

            maxFruits = Math.max(maxFruits, currSum);
            right++;
        }

        return maxFruits;
    }

    private boolean isValid(int[][] fruits, int startPos, int leftPos, int rightPos, int k) {
        int dist = Math.min(Math.abs(startPos - leftPos), Math.abs(startPos - rightPos)) + Math.abs(leftPos - rightPos);
        return dist <= k;
    }
}
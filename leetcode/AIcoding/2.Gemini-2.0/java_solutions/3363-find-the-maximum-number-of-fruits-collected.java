class Solution {
    public int maxTotalFruits(int[][] fruits, int startPos, int k) {
        int n = fruits.length;
        int left = 0;
        int right = 0;
        int currentSum = 0;
        int maxFruits = 0;

        while (right < n) {
            currentSum += fruits[right][1];

            while (left <= right && !isValid(fruits, startPos, left, right, k)) {
                currentSum -= fruits[left][1];
                left++;
            }

            if (isValid(fruits, startPos, left, right, k)) {
                maxFruits = Math.max(maxFruits, currentSum);
            }
            right++;
        }

        return maxFruits;
    }

    private boolean isValid(int[][] fruits, int startPos, int left, int right, int k) {
        int leftPos = fruits[left][0];
        int rightPos = fruits[right][0];

        int dist1 = Math.abs(startPos - leftPos) + Math.abs(rightPos - leftPos);
        int dist2 = Math.abs(startPos - rightPos) + Math.abs(rightPos - leftPos);

        return Math.min(dist1, dist2) <= k;
    }
}
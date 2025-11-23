class Solution {
    public boolean canThreePartsEqualSum(int[] A) {
        int totalSum = 0;
        for (int num : A) {
            totalSum += num;
        }
        if (totalSum % 3 != 0) {
            return false;
        }
        int target = totalSum / 3;
        int count = 0, currentSum = 0;
        for (int num : A) {
            currentSum += num;
            if (currentSum == target) {
                count++;
                currentSum = 0;
            }
        }
        return count >= 3;
    }
}
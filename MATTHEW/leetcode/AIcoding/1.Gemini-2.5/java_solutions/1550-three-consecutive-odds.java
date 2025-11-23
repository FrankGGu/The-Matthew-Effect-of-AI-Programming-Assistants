class Solution {
    public boolean threeConsecutiveOdds(int[] arr) {
        int consecutiveOddsCount = 0;
        for (int num : arr) {
            if (num % 2 != 0) {
                consecutiveOddsCount++;
                if (consecutiveOddsCount == 3) {
                    return true;
                }
            } else {
                consecutiveOddsCount = 0;
            }
        }
        return false;
    }
}
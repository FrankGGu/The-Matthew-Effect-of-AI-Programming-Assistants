class Solution {
    public int maxSatisfied(int[] customers, int[] grumpy, int X) {
        int totalSatisfied = 0;
        for (int i = 0; i < customers.length; i++) {
            if (grumpy[i] == 0) {
                totalSatisfied += customers[i];
            }
        }

        int maxExtraSatisfied = 0;
        int currentExtraSatisfied = 0;

        for (int i = 0; i < customers.length; i++) {
            if (grumpy[i] == 1) {
                currentExtraSatisfied += customers[i];
            }
            if (i >= X) {
                if (grumpy[i - X] == 1) {
                    currentExtraSatisfied -= customers[i - X];
                }
            }
            maxExtraSatisfied = Math.max(maxExtraSatisfied, currentExtraSatisfied);
        }

        return totalSatisfied + maxExtraSatisfied;
    }
}
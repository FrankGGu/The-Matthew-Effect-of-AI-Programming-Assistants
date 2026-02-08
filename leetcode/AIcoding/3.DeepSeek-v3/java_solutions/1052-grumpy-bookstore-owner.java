class Solution {
    public int maxSatisfied(int[] customers, int[] grumpy, int minutes) {
        int n = customers.length;
        int satisfied = 0;
        for (int i = 0; i < n; i++) {
            if (grumpy[i] == 0) {
                satisfied += customers[i];
            }
        }

        int maxIncrease = 0;
        int currentIncrease = 0;
        for (int i = 0; i < minutes; i++) {
            if (grumpy[i] == 1) {
                currentIncrease += customers[i];
            }
        }
        maxIncrease = currentIncrease;

        for (int i = minutes; i < n; i++) {
            if (grumpy[i] == 1) {
                currentIncrease += customers[i];
            }
            if (grumpy[i - minutes] == 1) {
                currentIncrease -= customers[i - minutes];
            }
            maxIncrease = Math.max(maxIncrease, currentIncrease);
        }

        return satisfied + maxIncrease;
    }
}
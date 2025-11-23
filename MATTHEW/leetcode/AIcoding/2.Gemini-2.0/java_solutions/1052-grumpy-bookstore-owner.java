class Solution {
    public int maxSatisfied(int[] customers, int[] grumpy, int minutes) {
        int satisfied = 0;
        for (int i = 0; i < customers.length; i++) {
            if (grumpy[i] == 0) {
                satisfied += customers[i];
            }
        }

        int maxPotential = 0;
        int currentPotential = 0;
        for (int i = 0; i < customers.length; i++) {
            if (grumpy[i] == 1) {
                currentPotential += customers[i];
            }

            if (i >= minutes) {
                if (grumpy[i - minutes] == 1) {
                    currentPotential -= customers[i - minutes];
                }
            }

            maxPotential = Math.max(maxPotential, currentPotential);
        }

        return satisfied + maxPotential;
    }
}
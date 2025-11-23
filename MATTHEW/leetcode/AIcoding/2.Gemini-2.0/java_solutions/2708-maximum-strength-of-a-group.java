class Solution {
    public long maxStrength(int[] nums) {
        long product = 1;
        int negativeCount = 0;
        int minNegative = Integer.MIN_VALUE;
        boolean hasZero = false;
        boolean hasPositive = false;

        for (int num : nums) {
            if (num > 0) {
                product *= num;
                hasPositive = true;
            } else if (num < 0) {
                product *= num;
                negativeCount++;
                minNegative = Math.max(minNegative, num);
            } else {
                hasZero = true;
            }
        }

        if (product == 1 && !hasPositive && !hasZero && negativeCount <= 1) {
            return 0;
        }

        if (product < 0 && negativeCount == 1 && !hasPositive && hasZero) {
            return 0;
        }

        if (product < 0 && negativeCount % 2 != 0) {
            if (negativeCount == 1 && !hasPositive && !hasZero) return 0;
            product /= minNegative;
        }

        if (product == 1 && !hasPositive && hasZero && negativeCount == 0) return 0;

        if (product == 1 && !hasPositive && negativeCount == 0 && hasZero) return 0;

        if (product == 1 && !hasPositive && negativeCount == 1 && hasZero) return 0;

        if (product == 1 && !hasPositive && negativeCount == 0 && !hasZero) return 1;

        if (product == 1 && !hasPositive && negativeCount == 1 && !hasZero) return 0;

        return product;
    }
}
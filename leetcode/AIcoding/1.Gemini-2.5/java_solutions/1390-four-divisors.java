class Solution {
    public int sumFourDivisors(int[] nums) {
        int totalSum = 0;
        for (int num : nums) {
            totalSum += getSumOfFourDivisors(num);
        }
        return totalSum;
    }

    private int getSumOfFourDivisors(int n) {
        if (n < 6) { 
            return 0;
        }

        int divisorCount = 0;
        int divisorSum = 0;

        int limit = (int) Math.sqrt(n);

        for (int i = 1; i <= limit; i++) {
            if (n % i == 0) {
                if (i * i == n) {
                    divisorCount++;
                    divisorSum += i;
                } else {
                    divisorCount += 2;
                    divisorSum += i + (n / i);
                }

                if (divisorCount > 4) {
                    return 0; 
                }
            }
        }

        if (divisorCount == 4) {
            return divisorSum;
        } else {
            return 0;
        }
    }
}
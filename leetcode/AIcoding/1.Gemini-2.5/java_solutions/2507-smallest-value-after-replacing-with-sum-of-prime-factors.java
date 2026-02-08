class Solution {
    public int smallestValue(int n) {
        while (true) {
            int sumOfFactors = getSumOfPrimeFactors(n);
            if (sumOfFactors == n) {
                return n;
            }
            n = sumOfFactors;
        }
    }

    private int getSumOfPrimeFactors(int num) {
        int sum = 0;

        while (num % 2 == 0) {
            sum += 2;
            num /= 2;
        }

        for (int i = 3; i * i <= num; i += 2) {
            while (num % i == 0) {
                sum += i;
                num /= i;
            }
        }

        if (num > 1) {
            sum += num;
        }
        return sum;
    }
}
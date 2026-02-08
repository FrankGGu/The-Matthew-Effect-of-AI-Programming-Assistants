class Solution {
    public int smallestValue(int n) {
        while (true) {
            int sum = getPrimeFactorsSum(n);
            if (sum == n) {
                break;
            }
            n = sum;
        }
        return n;
    }

    private int getPrimeFactorsSum(int num) {
        int sum = 0;
        int temp = num;
        for (int i = 2; i <= temp; i++) {
            while (temp % i == 0) {
                sum += i;
                temp /= i;
            }
        }
        return sum;
    }
}
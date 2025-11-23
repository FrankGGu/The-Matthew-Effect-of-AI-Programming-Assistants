class Solution {
    public int smallestValue(int n) {
        while (true) {
            int sum = 0;
            int temp = n;
            for (int i = 2; i * i <= temp; i++) {
                while (temp % i == 0) {
                    sum += i;
                    temp /= i;
                }
            }
            if (temp > 1) {
                sum += temp;
            }
            if (sum == n) {
                return n;
            }
            n = sum;
        }
    }
}
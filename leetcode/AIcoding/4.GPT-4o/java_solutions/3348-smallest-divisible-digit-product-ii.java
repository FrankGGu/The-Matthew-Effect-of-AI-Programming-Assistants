class Solution {
    public int smallestDivisible(int n) {
        int result = 1;
        for (int i = 2; i <= n; i++) {
            result = lcm(result, i);
        }
        return result;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    private int lcm(int a, int b) {
        return a / gcd(a, b) * b;
    }
}
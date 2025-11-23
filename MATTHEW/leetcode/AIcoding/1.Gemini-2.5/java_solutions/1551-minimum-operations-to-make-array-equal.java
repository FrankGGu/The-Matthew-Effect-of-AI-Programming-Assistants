class Solution {
    public int minOperations(int n) {
        int k = n / 2;
        if (n % 2 == 1) {
            return k * (k + 1);
        } else {
            return k * k;
        }
    }
}
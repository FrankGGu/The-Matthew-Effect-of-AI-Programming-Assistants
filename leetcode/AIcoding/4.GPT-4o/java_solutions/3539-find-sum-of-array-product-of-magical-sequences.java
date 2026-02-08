class Solution {
    public long findSumOfArrayProducts(int[] arr) {
        long sum = 0;
        int n = arr.length;
        long mod = 1000000007;

        for (int i = 0; i < n; i++) {
            long product = 1;
            for (int j = i; j < n; j++) {
                product = (product * arr[j]) % mod;
                sum = (sum + product) % mod;
            }
        }
        return sum;
    }
}
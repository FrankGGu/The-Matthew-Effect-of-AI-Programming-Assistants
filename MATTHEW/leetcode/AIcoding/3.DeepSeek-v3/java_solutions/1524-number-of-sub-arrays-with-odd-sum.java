class Solution {
    public int numOfSubarrays(int[] arr) {
        int mod = 1000000007;
        int odd = 0, even = 1; // even starts with 1 to account for sum 0
        int sum = 0;
        int result = 0;

        for (int num : arr) {
            sum += num;
            if (sum % 2 == 1) {
                result = (result + even) % mod;
                odd++;
            } else {
                result = (result + odd) % mod;
                even++;
            }
        }

        return result;
    }
}
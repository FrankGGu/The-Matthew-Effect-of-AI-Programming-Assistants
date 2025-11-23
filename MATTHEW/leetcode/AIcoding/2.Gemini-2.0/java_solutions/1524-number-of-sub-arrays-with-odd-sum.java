class Solution {
    public int numOfSubarrays(int[] arr) {
        int even = 1, odd = 0;
        int ans = 0;
        int mod = 1000000007;
        for (int num : arr) {
            if (num % 2 == 0) {
                even++;
            } else {
                int temp = even;
                even = odd;
                odd = temp + 1;
            }
            even %= mod;
            odd %= mod;
            ans = (ans + odd) % mod;
        }
        return ans;
    }
}
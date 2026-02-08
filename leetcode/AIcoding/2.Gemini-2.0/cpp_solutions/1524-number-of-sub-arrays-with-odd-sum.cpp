class Solution {
public:
    int numOfSubarrays(vector<int>& arr) {
        int even = 1, odd = 0;
        long long ans = 0;
        int mod = 1e9 + 7;

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
};
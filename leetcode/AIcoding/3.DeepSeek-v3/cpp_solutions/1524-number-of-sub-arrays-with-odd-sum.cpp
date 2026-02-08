class Solution {
public:
    int numOfSubarrays(vector<int>& arr) {
        int mod = 1e9 + 7;
        int odd = 0, even = 1; // even starts with 1 to account for sum 0
        int sum = 0;
        int res = 0;
        for (int num : arr) {
            sum += num;
            if (sum % 2 == 1) {
                res = (res + even) % mod;
                odd++;
            } else {
                res = (res + odd) % mod;
                even++;
            }
        }
        return res;
    }
};
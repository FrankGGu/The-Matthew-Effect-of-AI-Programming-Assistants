class Solution {
public:
    string subStrHash(string s, int k, int hashValue, int base, int mod) {
        int n = s.size();
        long long currHash = 0, power = 1;

        for (int i = 0; i < k; i++) {
            currHash = (currHash * base + (s[n - 1 - i] - 'a' + 1)) % mod;
            if (i < k - 1) power = (power * base) % mod;
        }

        for (int i = n - k; i >= 0; i--) {
            if (currHash == hashValue) return s.substr(i, k);
            if (i > 0) {
                currHash = (currHash - (s[i + k - 1] - 'a' + 1) * power % mod + mod) % mod;
                currHash = (currHash * base + (s[i - 1] - 'a' + 1)) % mod;
            }
        }

        return "";
    }
};
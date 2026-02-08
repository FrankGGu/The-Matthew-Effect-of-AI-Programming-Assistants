class Solution {
public:
    long long beautifulSubstrings(string s, int k) {
        int n = s.size();
        unordered_map<long long, int> mp;
        mp[0] = 1;
        long long res = 0;
        int balance = 0;
        int k1 = 1;
        for (int i = 1; i * i <= k; ++i) {
            if (i * i % k == 0) {
                k1 = i;
                break;
            }
        }
        for (int i = 0; i < n; ++i) {
            char c = s[i];
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                balance++;
            } else {
                balance--;
            }
            long long key = (long long)balance << 32 | (i % k1);
            res += mp[key];
            mp[key]++;
        }
        return res;
    }
};
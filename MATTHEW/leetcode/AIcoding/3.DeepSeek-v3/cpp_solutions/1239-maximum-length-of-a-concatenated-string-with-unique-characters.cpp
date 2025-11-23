class Solution {
public:
    int maxLength(vector<string>& arr) {
        vector<bitset<26>> dp = {bitset<26>()};
        int res = 0;
        for (string s : arr) {
            bitset<26> bs;
            for (char c : s) {
                bs.set(c - 'a');
            }
            if (bs.count() != s.size()) continue;

            for (int i = dp.size() - 1; i >= 0; --i) {
                bitset<26> tmp = dp[i];
                if ((tmp & bs).any()) continue;
                tmp |= bs;
                dp.push_back(tmp);
                res = max(res, (int)tmp.count());
            }
        }
        return res;
    }
};
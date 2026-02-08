class Solution {
public:
    int longestAwesome(string s) {
        unordered_map<int, int> mp;
        mp[0] = -1;
        int mask = 0, maxLength = 0;

        for (int i = 0; i < s.size(); ++i) {
            mask ^= (1 << (s[i] - '0'));
            if (mp.count(mask)) {
                maxLength = max(maxLength, i - mp[mask]);
            }
            for (int j = 0; j < 10; ++j) {
                int newMask = mask ^ (1 << j);
                if (mp.count(newMask)) {
                    maxLength = max(maxLength, i - mp[newMask]);
                }
            }
            if (!mp.count(mask)) {
                mp[mask] = i;
            }
        }
        return maxLength;
    }
};
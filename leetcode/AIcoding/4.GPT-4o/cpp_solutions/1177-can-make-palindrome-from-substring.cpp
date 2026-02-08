class Solution {
public:
    vector<bool> canMakePaliQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<int> prefix(26, 0);
        vector<bool> result;

        for (int i = 0; i < n; ++i) {
            prefix[s[i] - 'a']++;
        }

        for (const auto& query : queries) {
            int left = query[0], right = query[1], k = query[2];
            int oddCount = 0;
            for (int j = 0; j < 26; ++j) {
                if ((prefix[j] % 2) != 0) {
                    oddCount++;
                }
            }
            oddCount -= (prefix[s[right + 1] - 'a'] % 2);
            oddCount += ((prefix[s[left] - 'a'] - 1) % 2);
            result.push_back(oddCount / 2 <= k);
        }

        return result;
    }
};
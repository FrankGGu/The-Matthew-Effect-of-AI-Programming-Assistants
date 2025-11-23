class Solution {
public:
    vector<bool> canMakePaliQueries(string s, vector<vector<int>>& queries) {
        vector<bool> result;
        int n = s.size();
        vector<int> count(26, 0);
        vector<vector<int>> prefix(n + 1, vector<int>(26, 0));

        for (int i = 0; i < n; ++i) {
            count[s[i] - 'a']++;
            for (int j = 0; j < 26; ++j) {
                prefix[i + 1][j] = count[j];
            }
        }

        for (auto& q : queries) {
            int left = q[0], right = q[1], k = q[2];
            int oddCount = 0;
            for (int j = 0; j < 26; ++j) {
                if ((prefix[right + 1][j] - prefix[left][j]) % 2 == 1) {
                    oddCount++;
                }
            }
            if (oddCount / 2 <= k) {
                result.push_back(true);
            } else {
                result.push_back(false);
            }
        }

        return result;
    }
};
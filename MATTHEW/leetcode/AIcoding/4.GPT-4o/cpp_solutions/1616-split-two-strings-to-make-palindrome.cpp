class Solution {
public:
    bool canMakePaliQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }

        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (count[s[i] - 'a'] % 2);
        }

        vector<bool> results;
        for (auto& query : queries) {
            int left = query[0], right = query[1], k = query[2];
            int oddCount = prefix[right + 1] - prefix[left];
            if (oddCount / 2 <= k) {
                results.push_back(true);
            } else {
                results.push_back(false);
            }
        }

        return results;
    }
};
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<bool> canMakePaliQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<vector<int>> prefix(n + 1, vector<int>(26, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 26; ++j) {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][s[i] - 'a']++;
        }
        vector<bool> ans;
        for (auto& query : queries) {
            int left = query[0], right = query[1], k = query[2];
            int oddCount = 0;
            for (int i = 0; i < 26; ++i) {
                if ((prefix[right + 1][i] - prefix[left][i]) % 2 != 0) {
                    oddCount++;
                }
            }
            ans.push_back(oddCount / 2 <= k);
        }
        return ans;
    }
};
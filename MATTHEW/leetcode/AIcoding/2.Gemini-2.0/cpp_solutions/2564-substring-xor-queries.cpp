#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> substringXorQueries(string s, vector<vector<int>>& queries) {
        unordered_map<int, vector<int>> mp;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            int num = 0;
            for (int j = i; j < min(n, i + 32); ++j) {
                num = (num << 1) + (s[j] - '0');
                if (mp.find(num) == mp.end()) {
                    mp[num] = {i, j};
                }
            }
        }

        vector<vector<int>> ans;
        for (auto& q : queries) {
            int target = q[0] ^ q[1];
            if (mp.find(target) != mp.end()) {
                ans.push_back({mp[target][0], mp[target][1]});
            } else {
                ans.push_back({-1, -1});
            }
        }
        return ans;
    }
};
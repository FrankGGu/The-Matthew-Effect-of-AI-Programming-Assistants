#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxKDisjointSpecialSubstrings(string s, int k) {
        int n = s.size();
        if (n < k) return 0;

        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + (s[i] == '1' ? 1 : 0);
        }

        unordered_map<int, vector<int>> mp;
        mp[0].push_back(0);
        for (int i = 1; i <= n; ++i) {
            int val = 2 * prefix[i] - i;
            mp[val].push_back(i);
        }

        int res = 0;
        for (auto& [key, vec] : mp) {
            if (vec.size() < k) continue;
            for (int i = 0; i <= vec.size() - k; ++i) {
                int start = vec[i];
                int end = vec[i + k - 1];
                res = max(res, end - start);
            }
        }
        return res;
    }
};
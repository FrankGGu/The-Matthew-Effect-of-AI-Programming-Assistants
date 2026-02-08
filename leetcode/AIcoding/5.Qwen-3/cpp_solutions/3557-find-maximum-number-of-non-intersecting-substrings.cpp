#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maxSubstrings(string s) {
        int n = s.size();
        vector<int> dp(n, 0);
        vector<int> last(26, -1);
        vector<vector<int>> intervals;

        for (int i = 0; i < n; ++i) {
            if (last[s[i] - 'a'] != -1) {
                intervals.push_back({last[s[i] - 'a'], i});
            }
            last[s[i] - 'a'] = i;
        }

        sort(intervals.begin(), intervals.end());

        vector<vector<int>> res;
        int prevEnd = -1;

        for (const auto& interval : intervals) {
            if (interval[0] > prevEnd) {
                res.push_back(interval);
                prevEnd = interval[1];
            }
        }

        string result;
        for (const auto& interval : res) {
            result += s.substr(interval[0], interval[1] - interval[0] + 1);
        }

        return result;
    }
};
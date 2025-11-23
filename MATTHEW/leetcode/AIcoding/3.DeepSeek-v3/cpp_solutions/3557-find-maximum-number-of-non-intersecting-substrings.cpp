#include <vector>
#include <string>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        vector<int> first(26, INT_MAX);
        vector<int> last(26, INT_MIN);
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            first[c] = min(first[c], i);
            last[c] = max(last[c], i);
        }

        vector<pair<int, int>> intervals;
        for (int c = 0; c < 26; ++c) {
            if (first[c] == INT_MAX) continue;
            int left = first[c];
            int right = last[c];
            bool valid = true;
            for (int i = left; i <= right; ++i) {
                int curr = s[i] - 'a';
                if (first[curr] < left) {
                    valid = false;
                    break;
                }
                right = max(right, last[curr]);
            }
            if (valid) {
                intervals.emplace_back(right, left);
            }
        }

        sort(intervals.begin(), intervals.end());
        vector<string> res;
        int prev = -1;
        for (auto& interval : intervals) {
            int right = interval.first;
            int left = interval.second;
            if (left > prev) {
                res.push_back(s.substr(left, right - left + 1));
                prev = right;
            }
        }
        return res;
    }
};
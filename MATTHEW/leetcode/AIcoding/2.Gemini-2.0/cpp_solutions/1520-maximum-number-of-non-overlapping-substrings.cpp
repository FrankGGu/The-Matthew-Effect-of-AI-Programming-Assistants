#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        int n = s.length();
        vector<int> left(26, n);
        vector<int> right(26, -1);

        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            left[c] = min(left[c], i);
            right[c] = max(right[c], i);
        }

        vector<pair<int, int>> intervals;
        for (int i = 0; i < 26; ++i) {
            if (left[i] < right[i]) {
                int l = left[i];
                int r = right[i];
                for (int j = l; j <= r; ++j) {
                    int c = s[j] - 'a';
                    if (left[c] < l) {
                        l = left[c];
                        j = l - 1;
                    }
                    if (right[c] > r) {
                        r = right[c];
                    }
                }
                intervals.push_back({l, r});
            }
        }

        sort(intervals.begin(), intervals.end(), [](const auto& a, const auto& b) {
            return a.second < b.second;
        });

        vector<string> result;
        int end = -1;
        for (auto& interval : intervals) {
            if (interval.first > end) {
                result.push_back(s.substr(interval.first, interval.second - interval.first + 1));
                end = interval.second;
            }
        }

        return result;
    }
};
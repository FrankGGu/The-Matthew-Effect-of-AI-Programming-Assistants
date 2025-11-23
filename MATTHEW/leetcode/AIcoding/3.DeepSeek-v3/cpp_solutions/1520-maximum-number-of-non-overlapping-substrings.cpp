class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        vector<int> left(26, INT_MAX);
        vector<int> right(26, INT_MIN);
        for (int i = 0; i < s.size(); ++i) {
            left[s[i] - 'a'] = min(left[s[i] - 'a'], i);
            right[s[i] - 'a'] = max(right[s[i] - 'a'], i);
        }

        vector<pair<int, int>> intervals;
        for (int i = 0; i < 26; ++i) {
            if (left[i] == INT_MAX) continue;
            int l = left[i], r = right[i];
            bool valid = true;
            for (int j = l; j <= r; ++j) {
                if (left[s[j] - 'a'] < l) {
                    valid = false;
                    break;
                }
                r = max(r, right[s[j] - 'a']);
            }
            if (valid) {
                intervals.emplace_back(l, r);
            }
        }

        sort(intervals.begin(), intervals.end(), [](const auto& a, const auto& b) {
            return a.second < b.second;
        });

        vector<string> res;
        int prev = -1;
        for (const auto& interval : intervals) {
            if (interval.first > prev) {
                res.push_back(s.substr(interval.first, interval.second - interval.first + 1));
                prev = interval.second;
            }
        }
        return res;
    }
};
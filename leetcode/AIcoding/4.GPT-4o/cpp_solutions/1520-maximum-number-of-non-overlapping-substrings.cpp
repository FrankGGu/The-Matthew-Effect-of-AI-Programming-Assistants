class Solution {
public:
    vector<string> maxNumOfSubstrings(string s) {
        int n = s.size();
        vector<int> first(26, -1), last(26, -1);
        for (int i = 0; i < n; ++i) {
            last[s[i] - 'a'] = i;
            if (first[s[i] - 'a'] == -1) first[s[i] - 'a'] = i;
        }

        vector<pair<int, int>> intervals;
        for (int i = 0; i < 26; ++i) {
            if (first[i] != -1) {
                int l = first[i], r = last[i];
                for (int j = l; j <= r; ++j) {
                    r = max(r, last[s[j] - 'a']);
                }
                intervals.emplace_back(l, r);
            }
        }

        sort(intervals.begin(), intervals.end(), [](const auto &a, const auto &b) {
            return a.second < b.second;
        });

        vector<string> result;
        int end = -1;

        for (const auto &interval : intervals) {
            if (interval.first > end) {
                result.push_back(s.substr(interval.first, interval.second - interval.first + 1));
                end = interval.second;
            }
        }

        return result;
    }
};
#include <vector>
#include <string>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::string> maxNumOfSubstrings(std::string s) {
        std::vector<int> first(26, -1), last(26, -1);
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            int c = s[i] - 'a';
            if (first[c] == -1) {
                first[c] = i;
            }
            last[c] = i;
        }

        std::vector<std::pair<int, int>> intervals;
        for (int i = 0; i < 26; ++i) {
            if (first[i] != -1) {
                int start = first[i];
                int end = last[i];
                int j = start;
                bool possible = true;
                while (j <= end) {
                    int cur_c = s[j] - 'a';
                    if (first[cur_c] < start) {
                        possible = false;
                        break;
                    }
                    end = std::max(end, last[cur_c]);
                    j++;
                }
                if (possible) {
                    intervals.push_back({start, end});
                }
            }
        }

        std::sort(intervals.begin(), intervals.end(), [](const auto& a, const auto& b) {
            if (a.second != b.second) {
                return a.second < b.second;
            }
            return (a.second - a.first) < (b.second - b.first);
        });

        std::vector<std::string> result;
        int prev_end = -1;
        for (const auto& p : intervals) {
            if (p.first > prev_end) {
                result.push_back(s.substr(p.first, p.second - p.first + 1));
                prev_end = p.second;
            }
        }

        return result;
    }
};
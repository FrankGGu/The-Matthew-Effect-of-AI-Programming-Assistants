#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <utility>

class Solution {
public:
    struct Compare {
        bool operator()(const std::pair<char, int>& a, const std::pair<char, int>& b) {
            if (a.first != b.first) {
                return a.first < b.first;
            }
            return a.second > b.second;
        }
    };

    std::string removeStars(std::string s) {
        std::priority_queue<std::pair<char, int>, std::vector<std::pair<char, int>>, Compare> pq;

        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '*') {
                pq.pop();
            } else {
                pq.push({s[i], i});
            }
        }

        std::vector<std::pair<int, char>> result_chars;
        while (!pq.empty()) {
            result_chars.push_back({pq.top().second, pq.top().first});
            pq.pop();
        }

        std::sort(result_chars.begin(), result_chars.end());

        std::string result = "";
        for (const auto& p : result_chars) {
            result += p.second;
        }

        return result;
    }
};
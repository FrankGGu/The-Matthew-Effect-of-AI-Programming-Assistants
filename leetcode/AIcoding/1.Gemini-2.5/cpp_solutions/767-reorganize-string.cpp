#include <string>
#include <vector>
#include <queue>
#include <map>

class Solution {
public:
    std::string reorganizeString(std::string s) {
        std::map<char, int> counts;
        for (char c : s) {
            counts[c]++;
        }

        std::priority_queue<std::pair<int, char>> pq;
        int max_freq = 0;
        for (auto const& [key, val] : counts) {
            pq.push({val, key});
            if (val > max_freq) {
                max_freq = val;
            }
        }

        if (max_freq > (s.length() + 1) / 2) {
            return "";
        }

        std::string result = "";
        while (pq.size() >= 2) {
            std::pair<int, char> p1 = pq.top();
            pq.pop();
            std::pair<int, char> p2 = pq.top();
            pq.pop();

            result += p1.second;
            result += p2.second;

            p1.first--;
            p2.first--;

            if (p1.first > 0) {
                pq.push(p1);
            }
            if (p2.first > 0) {
                pq.push(p2);
            }
        }

        if (!pq.empty()) {
            result += pq.top().second;
        }

        return result;
    }
};
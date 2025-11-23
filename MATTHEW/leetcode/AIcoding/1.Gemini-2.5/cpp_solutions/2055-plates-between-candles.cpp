#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<int> platesBetweenCandles(std::string s, std::vector<std::vector<int>>& queries) {
        int n = s.length();

        std::vector<int> prefix_plates(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_plates[i + 1] = prefix_plates[i] + (s[i] == '*' ? 1 : 0);
        }

        std::vector<int> next_candle(n);
        int last_seen_candle = n; 
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == '|') {
                last_seen_candle = i;
            }
            next_candle[i] = last_seen_candle;
        }

        std::vector<int> prev_candle(n);
        last_seen_candle = -1; 
        for (int i = 0; i < n; ++i) {
            if (s[i] == '|') {
                last_seen_candle = i;
            }
            prev_candle[i] = last_seen_candle;
        }

        std::vector<int> results;
        results.reserve(queries.size());

        for (const auto& query : queries) {
            int left = query[0];
            int right = query[1];

            int first_candle_idx = next_candle[left];
            int last_candle_idx = prev_candle[right];

            if (first_candle_idx == n || last_candle_idx == -1 || first_candle_idx >= last_candle_idx) {
                results.push_back(0);
            } else {
                results.push_back(prefix_plates[last_candle_idx] - prefix_plates[first_candle_idx + 1]);
            }
        }

        return results;
    }
};
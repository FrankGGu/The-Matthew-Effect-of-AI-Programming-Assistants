#include <vector>

using namespace std;

class Solution {
public:
    vector<int> platesBetweenCandles(string s, vector<vector<int>>& queries) {
        int n = s.size();
        vector<int> candles;
        for (int i = 0; i < n; ++i) {
            if (s[i] == '|') {
                candles.push_back(i);
            }
        }

        vector<int> result;
        for (auto& query : queries) {
            int left = query[0];
            int right = query[1];

            auto left_candle_it = lower_bound(candles.begin(), candles.end(), left);
            auto right_candle_it = upper_bound(candles.begin(), candles.end(), right);

            if (left_candle_it == candles.end() || right_candle_it == candles.begin()) {
                result.push_back(0);
                continue;
            }

            right_candle_it--;

            if (*left_candle_it >= *right_candle_it) {
                result.push_back(0);
                continue;
            }

            int left_candle_index = *left_candle_it;
            int right_candle_index = *right_candle_it;

            int count = 0;
            for (int i = left_candle_index + 1; i < right_candle_index; ++i) {
                if (s[i] == '*') {
                    count++;
                }
            }
            result.push_back(count);
        }

        return result;
    }
};
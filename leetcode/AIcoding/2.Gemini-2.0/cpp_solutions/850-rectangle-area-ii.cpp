#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int rectangleArea(vector<vector<int>>& rectangles) {
        vector<int> x_coords;
        for (auto& rect : rectangles) {
            x_coords.push_back(rect[0]);
            x_coords.push_back(rect[2]);
        }
        sort(x_coords.begin(), x_coords.end());
        x_coords.erase(unique(x_coords.begin(), x_coords.end()), x_coords.end());

        long long area = 0;
        for (int i = 0; i < x_coords.size() - 1; ++i) {
            int x1 = x_coords[i];
            int x2 = x_coords[i + 1];
            vector<pair<int, int>> y_intervals;
            for (auto& rect : rectangles) {
                if (rect[0] <= x1 && x2 <= rect[2]) {
                    y_intervals.push_back({rect[1], rect[3]});
                }
            }

            sort(y_intervals.begin(), y_intervals.end());
            long long covered_length = 0;
            int current_start = -1;
            int current_end = -1;

            for (auto& interval : y_intervals) {
                if (interval.first > current_end) {
                    covered_length += (long long)max(0, current_end - current_start);
                    current_start = interval.first;
                    current_end = interval.second;
                } else {
                    current_end = max(current_end, interval.second);
                }
            }
            covered_length += (long long)max(0, current_end - current_start);

            area = (area + (long long)(x2 - x1) * covered_length) % 1000000007;
        }

        return (int)area;
    }
};
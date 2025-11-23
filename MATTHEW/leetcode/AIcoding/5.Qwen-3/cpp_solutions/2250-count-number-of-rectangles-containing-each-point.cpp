#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countRectangles(vector<vector<int>>& rectangles, vector<vector<int>>& points) {
        vector<int> result;
        vector<vector<int>> cnt(101);

        for (const auto& rect : rectangles) {
            int x = rect[0], y = rect[1];
            for (int i = y; i <= 100; ++i) {
                cnt[i].push_back(x);
            }
        }

        for (auto& vec : cnt) {
            sort(vec.begin(), vec.end());
        }

        for (const auto& point : points) {
            int x = point[0], y = point[1];
            int count = 0;
            for (int i = y; i <= 100; ++i) {
                auto it = lower_bound(cnt[i].begin(), cnt[i].end(), x);
                count += distance(it, cnt[i].end());
            }
            result.push_back(count);
        }

        return result;
    }
};
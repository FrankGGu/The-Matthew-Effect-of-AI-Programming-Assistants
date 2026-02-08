#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

int minGroups(vector<vector<int>>& intervals) {
    vector<pair<int, int>> points;
    for (const auto& interval : intervals) {
        points.emplace_back(interval[0], 1);
        points.emplace_back(interval[1] + 1, -1);
    }
    sort(points.begin(), points.end());

    int max_groups = 0, current_groups = 0;
    for (const auto& point : points) {
        current_groups += point.second;
        max_groups = max(max_groups, current_groups);
    }
    return max_groups;
}
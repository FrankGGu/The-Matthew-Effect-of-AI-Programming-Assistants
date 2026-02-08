#include <vector>
#include <algorithm>

using namespace std;

vector<int> findRightInterval(vector<vector<int>>& intervals) {
    int n = intervals.size();
    vector<pair<int, int>> startPoints(n);
    vector<int> result(n, -1);

    for (int i = 0; i < n; ++i) {
        startPoints[i] = {intervals[i][0], i};
    }

    sort(startPoints.begin(), startPoints.end());

    for (int i = 0; i < n; ++i) {
        int end = intervals[i][1];
        auto it = lower_bound(startPoints.begin(), startPoints.end(), make_pair(end, 0));
        if (it != startPoints.end()) {
            result[i] = it->second;
        }
    }

    return result;
}
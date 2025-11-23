#include <vector>
#include <algorithm>

using namespace std;

int cross_product(vector<int>& a, vector<int>& b, vector<int>& c) {
    return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0]);
}

vector<vector<int>> outerTrees(vector<vector<int>>& points) {
    int n = points.size();
    if (n <= 3) {
        return points;
    }

    sort(points.begin(), points.end());

    vector<vector<int>> hull;
    vector<bool> used(n, false);

    for (int i = 0; i < 2; ++i) {
        int t = hull.size();
        for (int j = 0; j < n; ++j) {
            if (used[j]) continue;
            while (hull.size() >= t + 2 && cross_product(hull[hull.size() - 2], hull.back(), points[j]) < 0) {
                used[distance(points.begin(), find(points.begin(), points.end(), hull.back()))] = false;
                hull.pop_back();
            }
            hull.push_back(points[j]);
            used[j] = true;
        }
        hull.pop_back();
        reverse(points.begin(), points.end());
        fill(used.begin(), used.end(), false);
    }

    sort(hull.begin(), hull.end());
    hull.erase(unique(hull.begin(), hull.end()), hull.end());

    return hull;
}
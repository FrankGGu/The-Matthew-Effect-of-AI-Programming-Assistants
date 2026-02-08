#include <algorithm>
#include <cmath>
#include <vector>

using namespace std;

double solve(vector<pair<int, int>>& points, double side) {
    double minX = 1e9, maxX = -1e9, minY = 1e9, maxY = -1e9;
    for (auto& p : points) {
        minX = min(minX, (double)p.first);
        maxX = max(maxX, (double)p.first);
        minY = min(minY, (double)p.second);
        maxY = max(maxY, (double)p.second);
    }
    return max({maxX - minX, maxY - minY, abs(maxX - side), abs(minX - side), abs(maxY - side), abs(minY - side)});
}

double maxDistance(vector<int>& x, vector<int>& y) {
    int n = x.size();
    vector<pair<int, int>> points(n);
    for (int i = 0; i < n; ++i) {
        points[i] = {x[i], y[i]};
    }

    double minSide = 1e9;
    for(auto& p : points){
        minSide = min(minSide, (double)p.first);
        minSide = min(minSide, (double)p.second);
    }

    double ans = 0.0;
    for(int i=0; i<8; ++i){
        ans = max(ans, solve(points, 0));
        ans = max(ans, solve(points, minSide));

        for(auto& p: points){
            int temp = p.first;
            p.first = p.second;
            p.second = temp;
        }

        for(auto& p: points){
            p.first = minSide - p.first;
        }
    }
    return ans;
}
#include <vector>
#include <unordered_map>

using namespace std;

struct Point {
    int x;
    int y;
    Point() : x(0), y(0) {}
    Point(int a, int b) : x(a), y(b) {}
};

int maxPoints(vector<Point>& points) {
    int n = points.size();
    if (n <= 2) return n;

    int max_points = 0;
    for (int i = 0; i < n; ++i) {
        unordered_map<double, int> slope_count;
        int same_points = 1;
        int vertical_points = 0;
        int current_max = 0;

        for (int j = i + 1; j < n; ++j) {
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                same_points++;
            } else if (points[i].x == points[j].x) {
                vertical_points++;
            } else {
                double slope = (double)(points[j].y - points[i].y) / (points[j].x - points[i].x);
                slope_count[slope]++;
                current_max = max(current_max, slope_count[slope]);
            }
        }
        current_max = max(current_max, vertical_points);
        max_points = max(max_points, current_max + same_points);
    }

    return max_points;
}
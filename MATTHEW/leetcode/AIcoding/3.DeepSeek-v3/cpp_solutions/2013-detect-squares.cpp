class DetectSquares {
public:
    unordered_map<int, unordered_map<int, int>> points;

    DetectSquares() {

    }

    void add(vector<int> point) {
        int x = point[0], y = point[1];
        points[x][y]++;
    }

    int count(vector<int> point) {
        int x = point[0], y = point[1];
        int res = 0;
        for (auto& [y2, cnt] : points[x]) {
            if (y2 == y) continue;
            int side = abs(y2 - y);
            int x1 = x + side;
            if (points.count(x1)) {
                if (points[x1].count(y) && points[x1].count(y2)) {
                    res += cnt * points[x1][y] * points[x1][y2];
                }
            }
            int x2 = x - side;
            if (points.count(x2)) {
                if (points[x2].count(y) && points[x2].count(y2)) {
                    res += cnt * points[x2][y] * points[x2][y2];
                }
            }
        }
        return res;
    }
};
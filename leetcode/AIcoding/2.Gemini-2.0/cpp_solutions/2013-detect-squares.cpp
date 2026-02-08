class DetectSquares {
public:
    DetectSquares() {

    }

    void add(vector<int> point) {
        points[point[0]][point[1]]++;
    }

    int count(vector<int> point) {
        int x = point[0], y = point[1];
        int res = 0;
        for (auto const& [px, row] : points) {
            for (auto const& [py, cnt] : row) {
                if (px != x && abs(px - x) == abs(py - y)) {
                    int side = abs(px - x);
                    if (points.count(x) && points[x].count(px > x ? y + side : y - side) && points.count(px) && points[px].count(px > x ? y + side : y - side)) {
                        res += cnt * points[x][px > x ? y + side : y - side] * points[px][px > x ? y + side : y - side];
                    }
                }
            }
        }
        return res;
    }

private:
    map<int, map<int, int>> points;
};
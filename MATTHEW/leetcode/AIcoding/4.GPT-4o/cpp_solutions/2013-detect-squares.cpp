#include <unordered_map>
#include <vector>

class DetectSquares {
public:
    DetectSquares() {}

    void add(vector<int> point) {
        points[{point[0], point[1]}]++;
    }

    int count(vector<int> point) {
        int x = point[0], y = point[1];
        int result = 0;

        for (auto& p : points) {
            int px = p.first.first, py = p.first.second;
            if (px != x && abs(px - x) == abs(py - y)) {
                result += p.second * points[{x, py}] * points[{px, y}];
            }
        }

        return result;
    }

private:
    std::unordered_map<std::pair<int, int>, int, std::hash<std::pair<int, int>>> points;
};
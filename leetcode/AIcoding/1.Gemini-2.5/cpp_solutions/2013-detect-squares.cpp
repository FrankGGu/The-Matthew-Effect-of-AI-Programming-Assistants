class DetectSquares {
public:
    std::vector<std::vector<int>> grid; 
    std::vector<std::pair<int, int>> points_list; 

    DetectSquares() {
        grid.resize(1001, std::vector<int>(1001, 0));
    }

    void add(std::vector<int> point) {
        int x = point[0];
        int y = point[1];
        if (grid[x][y] == 0) {
            points_list.push_back({x, y});
        }
        grid[x][y]++;
    }

    int count(std::vector<int> point) {
        int x1 = point[0];
        int y1 = point[1];
        int ans = 0;

        for (const auto& p2 : points_list) {
            int x2 = p2.first;
            int y2 = p2.second;

            if (x1 == x2 || y1 == y2 || std::abs(x1 - x2) != std::abs(y1 - y2)) {
                continue;
            }

            ans += grid[x2][y2] * grid[x1][y2] * grid[x2][y1];
        }

        return ans;
    }
};
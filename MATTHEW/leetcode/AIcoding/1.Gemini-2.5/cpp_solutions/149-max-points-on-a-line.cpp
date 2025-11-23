#include <vector>
#include <map>
#include <numeric> // For std::gcd
#include <algorithm> // For std::max, std::abs

class Solution {
public:
    int maxPoints(std::vector<std::vector<int>>& points) {
        int n = points.size();
        if (n <= 2) {
            return n;
        }

        int max_points = 0;

        for (int i = 0; i < n; ++i) {
            std::map<std::pair<int, int>, int> slopes;
            int duplicates = 0; 
            int current_max_on_line = 0; 

            for (int j = i + 1; j < n; ++j) {
                if (points[i][0] == points[j][0] && points[i][1] == points[j][1]) {
                    duplicates++;
                } else {
                    int dy = points[j][1] - points[i][1];
                    int dx = points[j][0] - points[i][0];

                    if (dx == 0) { 
                        dy = 1; 
                    } else if (dy == 0) { 
                        dx = 1; 
                    } else {
                        int common_divisor = std::gcd(std::abs(dy), std::abs(dx));
                        dy /= common_divisor;
                        dx /= common_divisor;

                        if (dx < 0 || (dx == 0 && dy < 0)) {
                            dx = -dx;
                            dy = -dy;
                        }
                    }

                    slopes[{dy, dx}]++;
                    current_max_on_line = std::max(current_max_on_line, slopes[{dy, dx}]);
                }
            }
            max_points = std::max(max_points, current_max_on_line + duplicates + 1);
        }

        return max_points;
    }
};
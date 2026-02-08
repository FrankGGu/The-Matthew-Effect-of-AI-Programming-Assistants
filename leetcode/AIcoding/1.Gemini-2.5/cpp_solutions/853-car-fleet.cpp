#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int carFleet(int target, std::vector<int>& position, std::vector<int>& speed) {
        int n = position.size();
        if (n == 0) {
            return 0;
        }

        std::vector<std::pair<int, int>> cars(n);
        for (int i = 0; i < n; ++i) {
            cars[i] = {position[i], speed[i]};
        }

        std::sort(cars.begin(), cars.end());

        double max_time = 0.0;
        int fleets = 0;

        for (int i = n - 1; i >= 0; --i) {
            double time = static_cast<double>(target - cars[i].first) / cars[i].second;
            if (time > max_time) {
                fleets++;
                max_time = time;
            }
        }

        return fleets;
    }
};
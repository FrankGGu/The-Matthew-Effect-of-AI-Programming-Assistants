#include <vector>
#include <numeric>

class Solution {
public:
    int wateringPlants(std::vector<int>& plants, int capacity) {
        int steps = 0;
        int current_water = capacity;
        int n = plants.size();

        for (int i = 0; i < n; ++i) {
            if (current_water < plants[i]) {
                steps += i * 2;
                current_water = capacity;
            }
            steps++;
            current_water -= plants[i];
        }
        return steps;
    }
};
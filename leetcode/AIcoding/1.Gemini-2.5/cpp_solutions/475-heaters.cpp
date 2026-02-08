#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int findRadius(std::vector<int>& houses, std::vector<int>& heaters) {
        std::sort(houses.begin(), houses.end());
        std::sort(heaters.begin(), heaters.end());

        int max_min_radius_for_all_houses = 0;
        int heater_pointer = 0;

        for (int house_pos : houses) {
            while (heater_pointer < heaters.size() - 1 && 
                   std::abs(house_pos - heaters[heater_pointer]) >= std::abs(house_pos - heaters[heater_pointer + 1])) {
                heater_pointer++;
            }

            int current_house_min_radius = std::abs(house_pos - heaters[heater_pointer]);

            max_min_radius_for_all_houses = std::max(max_min_radius_for_all_houses, current_house_min_radius);
        }

        return max_min_radius_for_all_houses;
    }
};
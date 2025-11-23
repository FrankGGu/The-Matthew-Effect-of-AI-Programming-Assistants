#include <vector>
#include <algorithm>

class Solution {
public:
    int maxConsecutive(int bottom, int top, std::vector<int>& special) {
        std::sort(special.begin(), special.end());

        int max_consecutive_floors = 0;

        // Calculate the consecutive floors from 'bottom' to the floor just before the first special floor
        max_consecutive_floors = std::max(max_consecutive_floors, special[0] - bottom);

        // Calculate the consecutive floors between adjacent special floors
        for (size_t i = 0; i < special.size() - 1; ++i) {
            max_consecutive_floors = std::max(max_consecutive_floors, special[i+1] - special[i] - 1);
        }

        // Calculate the consecutive floors from the floor just after the last special floor to 'top'
        max_consecutive_floors = std::max(max_consecutive_floors, top - special.back());

        return max_consecutive_floors;
    }
};
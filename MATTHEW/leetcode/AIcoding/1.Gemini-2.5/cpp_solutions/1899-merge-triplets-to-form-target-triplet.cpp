#include <vector>
#include <algorithm>

class Solution {
public:
    bool mergeTriplets(std::vector<std::vector<int>>& triplets, std::vector<int>& target) {
        bool found_x = false;
        bool found_y = false;
        bool found_z = false;

        for (const auto& triplet : triplets) {
            if (triplet[0] <= target[0] && 
                triplet[1] <= target[1] && 
                triplet[2] <= target[2]) {

                if (triplet[0] == target[0]) {
                    found_x = true;
                }
                if (triplet[1] == target[1]) {
                    found_y = true;
                }
                if (triplet[2] == target[2]) {
                    found_z = true;
                }
            }
        }

        return found_x && found_y && found_z;
    }
};
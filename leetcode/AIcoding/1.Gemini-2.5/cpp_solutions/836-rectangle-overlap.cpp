#include <vector>

class Solution {
public:
    bool isRectangleOverlap(std::vector<int>& rect1, std::vector<int>& rect2) {
        // Check if they don't overlap
        // If one rectangle is to the left of the other
        if (rect1[2] <= rect2[0] || rect2[2] <= rect1[0]) {
            return false;
        }
        // If one rectangle is below the other
        if (rect1[3] <= rect2[1] || rect2[3] <= rect1[1]) {
            return false;
        }

        // If none of the non-overlapping conditions are met, they must overlap
        return true;
    }
};
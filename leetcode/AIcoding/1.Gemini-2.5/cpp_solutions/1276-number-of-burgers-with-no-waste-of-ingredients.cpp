#include <vector>

class Solution {
public:
    std::vector<int> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        // Let j be the number of jumbo burgers and s be the number of small burgers.
        // Jumbo burger: 4 tomato slices, 1 cheese slice
        // Small burger: 2 tomato slices, 1 cheese slice

        // We have a system of two linear equations:
        // 1) 4j + 2s = tomatoSlices
        // 2) j + s = cheeseSlices

        // From equation (2), we can express s as: s = cheeseSlices - j
        // Substitute this expression for s into equation (1):
        // 4j + 2 * (cheeseSlices - j) = tomatoSlices
        // 4j + 2 * cheeseSlices - 2j = tomatoSlices
        // 2j + 2 * cheeseSlices = tomatoSlices
        // 2j = tomatoSlices - 2 * cheeseSlices
        // j = (tomatoSlices - 2 * cheeseSlices) / 2

        // For j and s to be valid burger counts, they must satisfy:
        // 1. j must be a non-negative integer.
        //    This implies (tomatoSlices - 2 * cheeseSlices) must be non-negative and even.
        //    Condition 1a: tomatoSlices - 2 * cheeseSlices >= 0  =>  tomatoSlices >= 2 * cheeseSlices
        //    Condition 1b: (tomatoSlices - 2 * cheeseSlices) % 2 == 0

        // 2. s must be a non-negative integer.
        //    s = cheeseSlices - j >= 0
        //    Substitute j: cheeseSlices - (tomatoSlices - 2 * cheeseSlices) / 2 >= 0
        //    Multiply by 2: 2 * cheeseSlices - (tomatoSlices - 2 * cheeseSlices) >= 0
        //    2 * cheeseSlices - tomatoSlices + 2 * cheeseSlices >= 0
        //    4 * cheeseSlices - tomatoSlices >= 0  =>  4 * cheeseSlices >= tomatoSlices

        // Combining all conditions:
        // tomatoSlices >= 2 * cheeseSlices
        // tomatoSlices <= 4 * cheeseSlices
        // (tomatoSlices - 2 * cheeseSlices) must be an even number

        if (tomatoSlices < 2 * cheeseSlices ||
            tomatoSlices > 4 * cheeseSlices ||
            (tomatoSlices - 2 * cheeseSlices) % 2 != 0) {
            return {}; // No valid non-negative integer solution
        }

        int jumboBurgers = (tomatoSlices - 2 * cheeseSlices) / 2;
        int smallBurgers = cheeseSlices - jumboBurgers;

        return {jumboBurgers, smallBurgers};
    }
};
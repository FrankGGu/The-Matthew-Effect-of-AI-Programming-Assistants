#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int kItemsWithMaximumSum(int numBottles, int numBoxes, int numCandies, int numEmptyBoxes) {
        int sum = 0;
        int usedBoxes = 0;

        while (numBottles > 0 && usedBoxes < numBoxes) {
            sum += numCandies;
            numBottles--;
            usedBoxes++;
        }

        return sum;
    }
};
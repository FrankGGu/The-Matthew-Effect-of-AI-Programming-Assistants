#include <vector>

class Solution {
public:
    int countBalls(int lowLimit, int highLimit) {
        std::vector<int> boxCounts(46, 0);

        for (int i = lowLimit; i <= highLimit; ++i) {
            int currentNum = i;
            int sumDigits = 0;
            while (currentNum > 0) {
                sumDigits += currentNum % 10;
                currentNum /= 10;
            }
            boxCounts[sumDigits]++;
        }

        int maxCount = 0;
        for (int count : boxCounts) {
            if (count > maxCount) {
                maxCount = count;
            }
        }

        return maxCount;
    }
};
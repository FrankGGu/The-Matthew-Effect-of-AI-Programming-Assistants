#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countBalls(int lowLimit, int highLimit) {
        unordered_map<int, int> boxCounts;
        int maxCount = 0;

        for (int i = lowLimit; i <= highLimit; ++i) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            boxCounts[sum]++;
            maxCount = max(maxCount, boxCounts[sum]);
        }

        return maxCount;
    }
};
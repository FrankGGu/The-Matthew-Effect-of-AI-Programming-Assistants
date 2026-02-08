#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> maximumEvenSplit(long long finalSum) {
        if (finalSum % 2 != 0) {
            return {};
        }

        vector<long long> result;
        long long currentSum = 0;
        long long currentNum = 2;

        while (currentSum + currentNum <= finalSum) {
            result.push_back(currentNum);
            currentSum += currentNum;
            currentNum += 2;
        }

        if (currentSum < finalSum) {
            result.back() += (finalSum - currentSum);
        }

        return result;
    }
};
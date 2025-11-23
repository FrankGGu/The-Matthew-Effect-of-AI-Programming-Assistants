#include <vector>
#include <numeric>

class Solution {
public:
    bool canThreePartsEqualSum(std::vector<int>& arr) {
        long long totalSum = std::accumulate(arr.begin(), arr.end(), 0LL);

        if (totalSum % 3 != 0) {
            return false;
        }

        long long target = totalSum / 3;
        long long currentSum = 0;
        int partsFound = 0;

        for (int i = 0; i < arr.size() - 1; ++i) {
            currentSum += arr[i];
            if (partsFound == 0 && currentSum == target) {
                partsFound = 1;
            } else if (partsFound == 1 && currentSum == 2 * target) {
                return true;
            }
        }

        return false;
    }
};
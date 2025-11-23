#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    bool canThreePartsEqualSum(vector<int>& arr) {
        int sum = accumulate(arr.begin(), arr.end(), 0);
        if (sum % 3 != 0) {
            return false;
        }

        int target = sum / 3;
        int count = 0;
        int currentSum = 0;

        for (int i = 0; i < arr.size(); ++i) {
            currentSum += arr[i];
            if (currentSum == target) {
                count++;
                currentSum = 0;
            }
        }

        return count >= 3;
    }
};
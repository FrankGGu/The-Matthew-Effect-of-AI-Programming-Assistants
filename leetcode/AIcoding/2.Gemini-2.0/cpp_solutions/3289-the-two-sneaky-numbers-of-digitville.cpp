#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> findTheNumbers(vector<int>& nums) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }

        int rightmostSetBit = xorSum & -xorSum;

        int num1 = 0;
        int num2 = 0;

        for (int num : nums) {
            if (num & rightmostSetBit) {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }

        return {min(num1, num2), max(num1, num2)};
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int waysToMakeFair(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        int evenSum = 0, oddSum = 0;
        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                evenSum += nums[i];
            } else {
                oddSum += nums[i];
            }
        }

        int count = 0;
        int leftEvenSum = 0, leftOddSum = 0;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                evenSum -= nums[i];
                if (leftEvenSum + oddSum == leftOddSum + evenSum) {
                    count++;
                }
                leftEvenSum += nums[i];
            } else {
                oddSum -= nums[i];
                if (leftEvenSum + oddSum == leftOddSum + evenSum) {
                    count++;
                }
                leftOddSum += nums[i];
            }
        }

        return count;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int sumOfSquares(vector<int>& nums) {
        int n = nums.size();
        int sum = 0;
        for (int i = 0; i < n; ++i) {
            if ((i + 1) % n == 0 || n % (i + 1) == 0) {
                sum += nums[i] * nums[i];
            }
        }
        return sum;
    }
};
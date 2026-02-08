#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int digitSum(int n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    int minimizeSum(vector<int>& nums) {
        for (int i = 0; i < nums.size(); ++i) {
            while (nums[i] >= 10) {
                nums[i] = digitSum(nums[i]);
            }
        }
        return *min_element(nums.begin(), nums.end());
    }
};
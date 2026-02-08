#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int findTheArrayConcVal(vector<int>& nums) {
        int left = 0;
        int right = nums.size() - 1;
        long long result = 0;

        while (left <= right) {
            if (left == right) {
                result += nums[left];
            } else {
                string combined = to_string(nums[left]) + to_string(nums[right]);
                result += stoll(combined);
            }
            left++;
            right--;
        }

        return result;
    }
};
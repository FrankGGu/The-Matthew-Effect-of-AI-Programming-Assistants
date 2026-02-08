#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long findTheArrayConcValue(vector<int>& nums) {
        long long result = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left <= right) {
            if (left == right) {
                result += nums[left];
            } else {
                string leftStr = to_string(nums[left]);
                string rightStr = to_string(nums[right]);
                string concat = leftStr + rightStr;
                result += stoll(concat);
            }
            left++;
            right--;
        }

        return result;
    }
};
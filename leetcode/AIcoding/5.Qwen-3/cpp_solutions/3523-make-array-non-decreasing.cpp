#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int findTheArrayConcaterationValue(vector<int>& nums) {
        int n = nums.size();
        int left = 0;
        int right = n - 1;
        int result = 0;

        while (left <= right) {
            if (left == right) {
                result += nums[left];
                break;
            }
            string leftStr = to_string(nums[left]);
            string rightStr = to_string(nums[right]);
            result += stoi(leftStr + rightStr);
            left++;
            right--;
        }

        return result;
    }
};
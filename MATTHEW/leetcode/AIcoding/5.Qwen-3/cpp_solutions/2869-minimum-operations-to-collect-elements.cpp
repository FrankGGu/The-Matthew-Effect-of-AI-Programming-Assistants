#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        stack<int> s;
        int count = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (s.empty() || s.top() != nums[i]) {
                s.push(nums[i]);
                ++count;
            }
        }
        return count;
    }
};
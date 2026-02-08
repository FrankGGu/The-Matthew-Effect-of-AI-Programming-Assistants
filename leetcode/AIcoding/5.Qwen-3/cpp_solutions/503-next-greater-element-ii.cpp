#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> nextGreaterElements(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n, -1);
        stack<int> s;

        for (int i = 0; i < 2 * n; ++i) {
            int num = nums[i % n];
            while (!s.empty() && nums[s.top()] < num) {
                int index = s.top();
                s.pop();
                result[index] = num;
            }
            if (i < n) {
                s.push(i);
            }
        }

        return result;
    }
};
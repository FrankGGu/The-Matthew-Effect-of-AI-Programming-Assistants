#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> mostCompetitive(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> result;
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[i] < s.top() && (n - i + s.size()) > k) {
                s.pop();
            }
            s.push(nums[i]);
        }

        while (s.size() > k) {
            s.pop();
        }

        while (!s.empty()) {
            result.push_back(s.top());
            s.pop();
        }

        reverse(result.begin(), result.end());
        return result;
    }
};
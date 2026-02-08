#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> mostCompetitive(vector<int>& nums, int k) {
        int n = nums.size();
        stack<int> s;
        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[i] < nums[s.top()] && n - i + s.size() > k) {
                s.pop();
            }
            if (s.size() < k) {
                s.push(i);
            }
        }
        vector<int> result(k);
        for (int i = k - 1; i >= 0; --i) {
            result[i] = nums[s.top()];
            s.pop();
        }
        return result;
    }
};
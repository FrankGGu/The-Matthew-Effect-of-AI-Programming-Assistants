#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> mostCompetitive(vector<int>& nums, int k) {
        stack<int> s;
        int n = nums.size();
        int toRemove = n - k;

        for (int num : nums) {
            while (!s.empty() && toRemove > 0 && s.top() > num) {
                s.pop();
                toRemove--;
            }
            s.push(num);
        }

        vector<int> result;
        while (!s.empty() && k > 0) {
            result.push_back(s.top());
            s.pop();
            k--;
        }

        reverse(result.begin(), result.end());
        return result;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        int count = 0;
        int operations = 0;
        vector<bool> collected(k + 1, false);
        for (int i = n - 1; i >= 0; i--) {
            operations++;
            if (nums[i] <= k && !collected[nums[i]]) {
                collected[nums[i]] = true;
                count++;
            }
            if (count == k) {
                return operations;
            }
        }
        return operations;
    }
};
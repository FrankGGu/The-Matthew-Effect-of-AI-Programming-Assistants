#include <vector>

using namespace std;

class Solution {
public:
    int solve(vector<int>& nums) {
        int n = nums.size();
        vector<int> ones, zeros;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) {
                zeros.push_back(i);
            } else {
                ones.push_back(i);
            }
        }

        if (ones.empty()) {
            return 0;
        }

        if (zeros.empty()) {
            return (n + 1) / 2;
        }

        int ans = 0;
        int i = 0, j = 0;
        while (i < ones.size()) {
            if (j < zeros.size() && ones[i] > zeros[j]) {
                j++;
            } else {
                ans++;
                i++;
            }
        }

        return ans;
    }
};
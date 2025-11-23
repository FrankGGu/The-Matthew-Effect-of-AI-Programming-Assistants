#include <vector>

using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums) {
        int n = nums.size();
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                vector<int> temp;
                for (int k = 0; k < n; ++k) {
                    if (k < i || k > j) {
                        temp.push_back(nums[k]);
                    }
                }
                if (temp.empty()) {
                    count++;
                    continue;
                }
                bool increasing = true;
                for (int k = 1; k < temp.size(); ++k) {
                    if (temp[k] <= temp[k - 1]) {
                        increasing = false;
                        break;
                    }
                }
                if (increasing) {
                    count++;
                }
            }
        }
        return count;
    }
};
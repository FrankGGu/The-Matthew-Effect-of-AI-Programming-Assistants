#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getSubarrayBeauty(vector<int>& nums, int k, int x) {
        vector<int> result;
        int n = nums.size();
        for (int i = 0; i <= n - k; ++i) {
            int count = 0;
            for (int j = i; j < i + k; ++j) {
                if (nums[j] < 0) {
                    count++;
                }
            }
            if (count < x) {
                result.push_back(0);
            } else {
                int xth_negative = 0;
                int negative_count = 0;
                for (int j = i; j < i + k; ++j) {
                    if (nums[j] < 0) {
                        negative_count++;
                        if (negative_count == x) {
                            xth_negative = nums[j];
                            break;
                        }
                    }
                }
                result.push_back(xth_negative);
            }
        }
        return result;
    }
};
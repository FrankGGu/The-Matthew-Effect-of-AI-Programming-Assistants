#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findGoodIndices(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        for (int i = 1; i < n; ++i) {
            if (nums[i] <= nums[i - 1]) {
                left[i] = left[i - 1] + 1;
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] <= nums[i + 1]) {
                right[i] = right[i + 1] + 1;
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (i - k >= 0 && i + k < n && left[i - 1] >= k && right[i + 1] >= k) {
                result.push_back(i);
            }
        }

        return result;
    }
};
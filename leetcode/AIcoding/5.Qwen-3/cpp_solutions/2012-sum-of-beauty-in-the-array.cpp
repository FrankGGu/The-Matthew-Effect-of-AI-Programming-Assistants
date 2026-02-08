#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int sumOfBeauty(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        for (int i = 1; i < n; ++i) {
            int count = 0;
            for (int j = 0; j < i; ++j) {
                if (nums[j] < nums[i]) {
                    ++count;
                }
            }
            left[i] = count;
        }

        for (int i = n - 2; i >= 0; --i) {
            int count = 0;
            for (int j = n - 1; j > i; --j) {
                if (nums[j] > nums[i]) {
                    ++count;
                }
            }
            right[i] = count;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            result += min(left[i], right[i]);
        }

        return result;
    }
};
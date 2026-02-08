#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numSubarraysWithKGoodElements(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (prefix[i + 1] - prefix[0] >= k) {
                for (int j = i + 1; j <= n; ++j) {
                    if (prefix[j] - prefix[i + 1] >= k) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    int numberOfGoodSubarrays(vector<int>& nums, int k) {
        return numSubarraysWithKGoodElements(nums, k);
    }
};
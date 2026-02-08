#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> numOfSubarrays(vector<int>& nums, vector<int>& queries) {
        int n = nums.size();
        int m = queries.size();
        vector<int> result(m, 0);

        for (int q = 0; q < m; ++q) {
            int k = queries[q];
            int count = 0;
            int current = 0;

            for (int i = 0; i < n; ++i) {
                if (nums[i] > k) {
                    current++;
                } else {
                    current = 0;
                }
                count += current;
            }

            result[q] = count;
        }

        return result;
    }
};
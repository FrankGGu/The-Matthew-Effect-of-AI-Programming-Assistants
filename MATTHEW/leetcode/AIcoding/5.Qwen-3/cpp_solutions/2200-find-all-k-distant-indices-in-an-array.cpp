#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findKDistantIndices(const vector<int>& nums, int k) {
        vector<int> result;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (abs(i - j) <= k) {
                    result.push_back(j);
                }
            }
        }
        return result;
    }
};
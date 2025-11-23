#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findBeautifulIndices(int n, vector<int>& nums, int k) {
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            bool isBeautiful = true;
            for (int j = 0; j < n; ++j) {
                if (i != j && abs(nums[i] - nums[j]) <= k) {
                    isBeautiful = false;
                    break;
                }
            }
            if (isBeautiful) {
                result.push_back(i);
            }
        }
        return result;
    }
};
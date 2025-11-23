#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxSubarrayWithEqualProducts(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        unordered_map<long long, int> prefixMap;
        prefixMap[1] = -1;

        long long product = 1;
        int maxLen = 0;

        for (int i = 0; i < n; ++i) {
            product *= nums[i];
            if (product == 0) {
                product = 1;
                prefixMap.clear();
                prefixMap[1] = i;
                continue;
            }

            if (prefixMap.find(product) != prefixMap.end()) {
                maxLen = max(maxLen, i - prefixMap[product]);
            } else {
                prefixMap[product] = i;
            }
        }

        return maxLen;
    }
};
#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int maxSubarrayLength(vector<int>& nums) {
        unordered_map<long long, int> prefixProductMap;
        prefixProductMap[1] = -1;
        long long prefixProduct = 1;
        int maxLen = 0;

        for (int i = 0; i < nums.size(); ++i) {
            prefixProduct *= nums[i];
            if (prefixProductMap.find(prefixProduct) != prefixProductMap.end()) {
                maxLen = max(maxLen, i - prefixProductMap[prefixProduct]);
            } else {
                prefixProductMap[prefixProduct] = i;
            }
        }

        return maxLen;
    }
};
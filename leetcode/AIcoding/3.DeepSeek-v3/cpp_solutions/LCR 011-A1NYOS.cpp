#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        unordered_map<int, int> prefixMap;
        prefixMap[0] = -1;
        int maxLen = 0;
        int prefix = 0;

        for (int i = 0; i < nums.size(); ++i) {
            prefix += (nums[i] == 1) ? 1 : -1;
            if (prefixMap.find(prefix) != prefixMap.end()) {
                maxLen = max(maxLen, i - prefixMap[prefix]);
            } else {
                prefixMap[prefix] = i;
            }
        }

        return maxLen;
    }
};
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findMaxLength(vector<int>& nums) {
        int maxLen = 0;
        int count = 0;
        unordered_map<int, int> countMap;
        countMap[0] = -1;

        for (int i = 0; i < nums.size(); ++i) {
            count += (nums[i] == 1 ? 1 : -1);

            if (countMap.count(count)) {
                maxLen = max(maxLen, i - countMap[count]);
            } else {
                countMap[count] = i;
            }
        }

        return maxLen;
    }
};
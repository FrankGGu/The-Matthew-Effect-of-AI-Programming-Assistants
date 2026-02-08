#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool checkSubarraySum(vector<int>& nums, int k) {
        unordered_map<int, int> remainderMap;
        remainderMap[0] = -1;
        int runningSum = 0;
        for (int i = 0; i < nums.size(); i++) {
            runningSum += nums[i];
            if (k != 0) {
                runningSum %= k;
            }
            if (remainderMap.count(runningSum)) {
                if (i - remainderMap[runningSum] > 1) {
                    return true;
                }
            } else {
                remainderMap[runningSum] = i;
            }
        }
        return false;
    }
};
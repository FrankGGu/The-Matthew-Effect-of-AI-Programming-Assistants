#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int subarraySum(vector<int>& nums, int k) {
        int count = 0;
        int sum = 0;
        unordered_map<int, int> sumMap;
        sumMap[0] = 1;

        for (int i = 0; i < nums.size(); i++) {
            sum += nums[i];
            if (sumMap.find(sum - k) != sumMap.end()) {
                count += sumMap[sum - k];
            }
            sumMap[sum]++;
        }

        return count;
    }
};
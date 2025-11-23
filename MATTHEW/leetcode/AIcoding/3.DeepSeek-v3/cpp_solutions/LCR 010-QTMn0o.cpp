#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int subarraySum(vector<int>& nums, int k) {
        unordered_map<int, int> prefixSum;
        prefixSum[0] = 1;
        int currentSum = 0;
        int count = 0;

        for (int num : nums) {
            currentSum += num;
            if (prefixSum.find(currentSum - k) != prefixSum.end()) {
                count += prefixSum[currentSum - k];
            }
            prefixSum[currentSum]++;
        }

        return count;
    }
};
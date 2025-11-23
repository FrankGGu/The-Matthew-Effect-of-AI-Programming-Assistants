#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfGoodPartitions(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> lastOccurrence;
        for (int i = 0; i < n; ++i) {
            lastOccurrence[nums[i]] = i;
        }

        int partitions = 0;
        int maxIndex = -1;
        int currentMax = -1;
        for (int i = 0; i < n; ++i) {
            currentMax = max(currentMax, lastOccurrence[nums[i]]);
            if (i == currentMax) {
                partitions++;
            }
        }

        long long result = 1;
        long long mod = 1e9 + 7;
        if (partitions == 0) return 0;

        for (int i = 0; i < partitions - 1; ++i) {
            result = (result * 2) % mod;
        }

        return (int)result;
    }
};
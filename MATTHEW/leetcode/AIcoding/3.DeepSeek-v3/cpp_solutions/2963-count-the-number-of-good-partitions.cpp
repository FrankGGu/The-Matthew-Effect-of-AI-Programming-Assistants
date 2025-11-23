#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int countGoodPartitions(vector<int>& nums) {
        unordered_map<int, int> lastOccurrence;
        for (int i = 0; i < nums.size(); ++i) {
            lastOccurrence[nums[i]] = i;
        }

        int res = 1;
        int maxPos = 0;
        for (int i = 0; i < nums.size(); ++i) {
            maxPos = max(maxPos, lastOccurrence[nums[i]]);
            if (i == maxPos) {
                res = (res * 2) % 1000000007;
            }
        }
        return res / 2;
    }
};
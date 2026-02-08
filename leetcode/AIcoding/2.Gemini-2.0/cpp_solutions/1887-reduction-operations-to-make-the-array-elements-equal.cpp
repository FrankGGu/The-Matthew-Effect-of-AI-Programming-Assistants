#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int reductionOperations(vector<int>& nums) {
        map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> uniqueNums;
        for (auto const& [key, val] : counts) {
            uniqueNums.push_back(key);
        }

        sort(uniqueNums.begin(), uniqueNums.end());

        int operations = 0;
        int accumulatedCount = 0;
        for (int i = 1; i < uniqueNums.size(); ++i) {
            accumulatedCount += counts[uniqueNums[i-1]];
            operations += accumulatedCount;
        }

        return operations;
    }
};
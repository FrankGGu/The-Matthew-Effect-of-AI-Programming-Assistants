#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int reductionOperations(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int operations = 0;
        int distinct_count = 0;
        for (int i = 1; i < n; ++i) {
            if (nums[i] != nums[i - 1]) {
                distinct_count++;
            }
            operations += distinct_count;
        }
        return operations;
    }
};
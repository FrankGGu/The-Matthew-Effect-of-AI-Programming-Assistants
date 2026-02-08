#include <vector>

using namespace std;

class Solution {
public:
    long long countAlternatingSubarrays(vector<int>& nums) {
        int n = nums.size();
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                bool alternating = true;
                for (int k = i; k < j; ++k) {
                    if (nums[k] == nums[k + 1]) {
                        alternating = false;
                        break;
                    }
                }
                if (alternating) {
                    count++;
                }
            }
        }
        return count;
    }
};
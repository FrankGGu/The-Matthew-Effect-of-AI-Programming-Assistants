#include <vector>
#include <algorithm>

class Solution {
public:
    long long countSubarrays(std::vector<int>& nums, int minK, int maxK) {
        long long count = 0;
        int leftBound = 0; 
        int lastMinK = -1; 
        int lastMaxK = -1; 

        for (int right = 0; right < nums.size(); ++right) {
            if (nums[right] < minK || nums[right] > maxK) {
                leftBound = right + 1; 
                lastMinK = -1;         
                lastMaxK = -1;         
            } else {
                if (nums[right] == minK) {
                    lastMinK = right;
                }
                if (nums[right] == maxK) {
                    lastMaxK = right;
                }

                if (lastMinK != -1 && lastMaxK != -1) {
                    count += std::max(0, std::min(lastMinK, lastMaxK) - leftBound + 1);
                }
            }
        }
        return count;
    }
};
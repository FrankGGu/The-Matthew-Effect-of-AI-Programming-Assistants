#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxNonOverlapping(vector<int>& nums, int target) {
        int count = 0;
        int sum = 0;
        unordered_map<int, int> seen;
        seen[0] = -1;
        int last = -1;

        for (int i = 0; i < nums.size(); ++i) {
            sum += nums[i];
            if (seen.count(sum - target)) {
                int start = seen[sum - target];
                if (start < last) {
                    seen[sum] = i;
                    continue;
                }

                count++;
                last = i;
                seen[sum] = i;
            } else {
                seen[sum] = i;
            }
        }

        return count;
    }
};
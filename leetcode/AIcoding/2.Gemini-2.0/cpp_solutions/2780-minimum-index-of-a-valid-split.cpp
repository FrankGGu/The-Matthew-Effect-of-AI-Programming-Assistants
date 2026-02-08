#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumIndex(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int dominant = -1;
        int maxCount = 0;
        for (auto const& [num, count] : counts) {
            if (count > maxCount) {
                maxCount = count;
                dominant = num;
            }
        }

        int totalDominantCount = 0;
        for (int num : nums) {
            if (num == dominant) {
                totalDominantCount++;
            }
        }

        int leftDominantCount = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] == dominant) {
                leftDominantCount++;
            }
            if (leftDominantCount * 2 > (i + 1) && (totalDominantCount - leftDominantCount) * 2 > (n - i - 1)) {
                return i;
            }
        }

        return -1;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int smallestRotation(vector<int>& nums) {
        int n = nums.size();
        vector<int> diff(n, 0);
        for (int i = 0; i < n; ++i) {
            int loss = (i - nums[i] + 1 + n) % n;
            diff[loss]--;
        }
        int maxScore = 0, maxIndex = 0, score = 0;
        for (int i = 0; i < n; ++i) {
            score += diff[i] + 1;
            if (score > maxScore) {
                maxScore = score;
                maxIndex = i;
            }
        }
        return maxIndex;
    }
};
#include <vector>

using namespace std;

class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        int score = nums[0] + nums[1];
        int count = 1;
        for (int i = 2; i < n - 1; i += 2) {
            if (nums[i] + nums[i + 1] == score) {
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};
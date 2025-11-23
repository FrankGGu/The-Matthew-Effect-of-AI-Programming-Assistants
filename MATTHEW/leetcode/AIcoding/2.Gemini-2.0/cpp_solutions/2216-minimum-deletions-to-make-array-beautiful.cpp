#include <vector>

using namespace std;

class Solution {
public:
    int minDeletion(vector<int>& nums) {
        int deletions = 0;
        int n = nums.size();
        int i = 0;
        while (i < n - deletions - 1) {
            if ((i % 2 == 0) && (nums[i] == nums[i + 1])) {
                deletions++;
                nums.erase(nums.begin() + i);
                n--;
            } else {
                i++;
            }
        }
        if ((n - deletions) % 2 != 0) {
            deletions++;
        }
        return deletions;
    }
};
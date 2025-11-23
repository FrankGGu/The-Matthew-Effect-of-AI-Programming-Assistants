#include <vector>

using namespace std;

class Solution {
public:
    bool circularArrayLoop(vector<int>& nums) {
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) continue;

            int slow = i, fast = i;
            bool direction = nums[i] > 0;

            while (true) {
                slow = next(nums, slow);
                if (nums[slow] == 0 || (nums[slow] > 0) != direction) break;

                fast = next(nums, fast);
                if (nums[fast] == 0 || (nums[fast] > 0) != direction) break;
                fast = next(nums, fast);
                if (nums[fast] == 0 || (nums[fast] > 0) != direction) break;

                if (slow == fast) {
                    if (slow == next(nums, slow)) break;
                    return true;
                }
            }

            slow = i;
            while (nums[slow] != 0 && (nums[slow] > 0) == direction) {
                int next_val = next(nums, slow);
                int temp = nums[slow];
                nums[slow] = 0;
                slow = next_val;
            }
        }

        return false;
    }

private:
    int next(vector<int>& nums, int i) {
        int n = nums.size();
        return ((i + nums[i]) % n + n) % n;
    }
};
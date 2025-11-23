#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int movesToMakeZigzag(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        int odd_moves = 0;
        vector<int> odd_nums = nums;
        for (int i = 1; i < n; i += 2) {
            int decrease = 0;
            if (i > 0 && odd_nums[i] >= odd_nums[i - 1]) {
                decrease = max(decrease, odd_nums[i] - odd_nums[i - 1] + 1);
            }
            if (i < n - 1 && odd_nums[i] >= odd_nums[i + 1]) {
                decrease = max(decrease, odd_nums[i] - odd_nums[i + 1] + 1);
            }
            odd_moves += decrease;

        }

        int even_moves = 0;
        vector<int> even_nums = nums;
        for (int i = 0; i < n; i += 2) {
            int decrease = 0;
            if (i > 0 && even_nums[i] >= even_nums[i - 1]) {
                decrease = max(decrease, even_nums[i] - even_nums[i - 1] + 1);
            }
            if (i < n - 1 && even_nums[i] >= even_nums[i + 1]) {
                decrease = max(decrease, even_nums[i] - even_nums[i + 1] + 1);
            }
            even_moves += decrease;

        }

        return min(odd_moves, even_moves);
    }
};
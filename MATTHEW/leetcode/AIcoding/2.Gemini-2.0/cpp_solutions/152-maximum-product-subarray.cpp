#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int maxProduct(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        int max_so_far = nums[0];
        int min_so_far = nums[0];
        int result = nums[0];

        for (int i = 1; i < n; i++) {
            int curr = nums[i];
            int temp_max = max({curr, max_so_far * curr, min_so_far * curr});
            min_so_far = min({curr, max_so_far * curr, min_so_far * curr});

            max_so_far = temp_max;

            result = max(result, max_so_far);
        }

        return result;
    }
};
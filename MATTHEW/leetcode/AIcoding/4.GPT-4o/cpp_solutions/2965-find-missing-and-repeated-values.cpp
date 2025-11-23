#include <vector>
#include <utility>

std::vector<int> findErrorNums(std::vector<int>& nums) {
    int n = nums.size();
    std::vector<int> result(2);
    std::vector<bool> seen(n + 1, false);

    for (int num : nums) {
        if (seen[num]) {
            result[0] = num; // the repeated number
        }
        seen[num] = true;
    }

    for (int i = 1; i <= n; ++i) {
        if (!seen[i]) {
            result[1] = i; // the missing number
            break;
        }
    }

    return result;
}
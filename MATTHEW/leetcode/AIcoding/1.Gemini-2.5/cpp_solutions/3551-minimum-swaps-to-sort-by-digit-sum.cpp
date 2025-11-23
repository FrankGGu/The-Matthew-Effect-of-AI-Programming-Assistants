#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

int digitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

class Solution {
public:
    int minimumSwaps(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        std::vector<std::pair<std::pair<int, int>, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = {{digitSum(nums[i]), nums[i]}, i};
        }

        std::sort(arr.begin(), arr.end());

        std::vector<bool> visited(n, false);
        int swaps = 0;

        for (int i = 0; i < n; ++i) {
            if (visited[i] || arr[i].second == i) {
                continue;
            }

            int cycle_size = 0;
            int current_node = i;
            while (!visited[current_node]) {
                visited[current_node] = true;
                current_node = arr[current_node].second;
                cycle_size++;
            }
            swaps += (cycle_size - 1);
        }

        return swaps;
    }
};
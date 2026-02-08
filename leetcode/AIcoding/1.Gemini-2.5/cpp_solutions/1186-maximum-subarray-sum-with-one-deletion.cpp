#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumSum(std::vector<int>& arr) {
        int n = arr.size();
        if (n == 0) {
            return 0;
        }

        int max_ending_here_no_del = arr[0];
        int max_ending_here_one_del = arr[0];
        int max_so_far = arr[0];

        for (int i = 1; i < n; ++i) {
            max_ending_here_one_del = std::max(max_ending_here_one_del + arr[i], max_ending_here_no_del);
            max_ending_here_no_del = std::max(max_ending_here_no_del + arr[i], arr[i]);
            max_so_far = std::max({max_so_far, max_ending_here_no_del, max_ending_here_one_del});
        }

        return max_so_far;
    }
};
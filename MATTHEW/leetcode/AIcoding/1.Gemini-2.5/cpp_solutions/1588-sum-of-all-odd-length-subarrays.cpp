#include <vector>
#include <numeric>

class Solution {
public:
    int sumOddLengthSubarrays(std::vector<int>& arr) {
        int n = arr.size();
        int total_sum = 0;

        for (int i = 0; i < n; ++i) {
            int left_count = i + 1;
            int right_count = n - i;

            int occurrences = (left_count * right_count + 1) / 2;

            total_sum += arr[i] * occurrences;
        }

        return total_sum;
    }
};
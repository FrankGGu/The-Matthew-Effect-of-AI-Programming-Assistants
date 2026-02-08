#include <vector>
#include <algorithm>
#include <numeric>
#include <iomanip>

class Solution {
public:
    double trimMean(std::vector<int>& arr) {
        std::sort(arr.begin(), arr.end());
        int n = arr.size();
        int remove_count = n / 20;

        double sum = 0.0;
        for (int i = remove_count; i < n - remove_count; ++i) {
            sum += arr[i];
        }

        int remaining_elements_count = n - 2 * remove_count;

        return sum / remaining_elements_count;
    }
};
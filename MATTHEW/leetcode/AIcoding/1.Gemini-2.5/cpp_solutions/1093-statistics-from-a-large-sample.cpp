#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<double> sampleStats(std::vector<int>& count) {
        double minimum = 256.0;
        double maximum = -1.0;
        double mean = 0.0;
        double median = 0.0;
        double mode = 0.0;

        long long total_sum = 0;
        long long total_count = 0;
        int max_freq = 0;

        for (int i = 0; i < 256; ++i) {
            if (count[i] > 0) {
                if (minimum == 256.0) {
                    minimum = i;
                }
                maximum = i;

                total_sum += (long long)i * count[i];
                total_count += count[i];

                if (count[i] > max_freq) {
                    max_freq = count[i];
                    mode = i;
                }
            }
        }

        if (total_count > 0) {
            mean = (double)total_sum / total_count;
        }

        double median_val1 = 0.0;
        double median_val2 = 0.0;
        long long current_elements_passed = 0;

        long long target1_idx = (total_count - 1) / 2;
        long long target2_idx = total_count / 2;

        for (int i = 0; i < 256; ++i) {
            if (count[i] > 0) {
                if (current_elements_passed <= target1_idx && current_elements_passed + count[i] > target1_idx) {
                    median_val1 = i;
                }
                if (current_elements_passed <= target2_idx && current_elements_passed + count[i] > target2_idx) {
                    median_val2 = i;
                }
                current_elements_passed += count[i];
            }
        }
        median = (median_val1 + median_val2) / 2.0;

        return {minimum, maximum, mean, median, mode};
    }
};
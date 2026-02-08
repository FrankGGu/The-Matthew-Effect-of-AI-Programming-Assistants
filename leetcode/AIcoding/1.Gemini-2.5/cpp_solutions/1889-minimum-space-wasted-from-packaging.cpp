#include <vector>
#include <algorithm>
#include <numeric>
#include <limits>

class Solution {
public:
    int minSpaceWastedFromPackaging(std::vector<int>& packages, std::vector<std::vector<int>>& boxes) {
        const long long MOD = 1e9 + 7;

        std::sort(packages.begin(), packages.end());

        std::vector<long long> prefix_sum_packages(packages.size() + 1, 0);
        for (int i = 0; i < packages.size(); ++i) {
            prefix_sum_packages[i+1] = prefix_sum_packages[i] + packages[i];
        }

        long long min_total_waste = std::numeric_limits<long long>::max();

        for (auto& supplier_boxes : boxes) {
            std::sort(supplier_boxes.begin(), supplier_boxes.end());

            if (packages.back() > supplier_boxes.back()) {
                continue;
            }

            long long current_supplier_waste = 0;
            int package_ptr = 0;

            for (int box_size : supplier_boxes) {
                auto it = std::upper_bound(packages.begin() + package_ptr, packages.end(), box_size);
                int next_package_ptr = std::distance(packages.begin(), it);

                long long num_covered_packages = next_package_ptr - package_ptr;

                if (num_covered_packages > 0) {
                    long long sum_covered_packages = prefix_sum_packages[next_package_ptr] - prefix_sum_packages[package_ptr];
                    current_supplier_waste += num_covered_packages * box_size - sum_covered_packages;
                }

                package_ptr = next_package_ptr;

                if (package_ptr == packages.size()) {
                    break;
                }
            }

            min_total_waste = std::min(min_total_waste, current_supplier_waste);
        }

        if (min_total_waste == std::numeric_limits<long long>::max()) {
            return -1;
        } else {
            return min_total_waste % MOD;
        }
    }
};
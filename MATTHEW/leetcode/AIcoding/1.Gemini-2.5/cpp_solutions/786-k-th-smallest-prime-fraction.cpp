#include <vector>
#include <queue>
#include <utility>
#include <tuple>

struct FractionComparator {
    const std::vector<int>& arr;

    FractionComparator(const std::vector<int>& a) : arr(a) {}

    bool operator()(const std::pair<int, int>& f1_indices, const std::pair<int, int>& f2_indices) {
        // Compare arr[f1_indices.first] / arr[f1_indices.second] with arr[f2_indices.first] / arr[f2_indices.second]
        // This is equivalent to comparing arr[f1_indices.first] * arr[f2_indices.second] with arr[f2_indices.first] * arr[f1_indices.second]
        // Use long long to prevent overflow for cross-multiplication
        return (long long)arr[f1_indices.first] * arr[f2_indices.second] > (long long)arr[f2_indices.first] * arr[f1_indices.second];
    }
};

class Solution {
public:
    std::vector<int> kthSmallestPrimeFraction(std::vector<int>& arr, int k) {
        int n = arr.size();

        std::priority_queue<std::pair<int, int>, 
                            std::vector<std::pair<int, int>>, 
                            FractionComparator> pq(FractionComparator(arr));

        for (int j = 1; j < n; ++j) {
            pq.push({0, j}); // (numerator_index, denominator_index)
        }

        for (int count = 0; count < k - 1; ++count) {
            std::pair<int, int> current_fraction_indices = pq.top();
            pq.pop();

            int i = current_fraction_indices.first;
            int j = current_fraction_indices.second;

            if (i + 1 < j) {
                pq.push({i + 1, j});
            }
        }

        std::pair<int, int> result_indices = pq.top();
        return {arr[result_indices.first], arr[result_indices.second]};
    }
};
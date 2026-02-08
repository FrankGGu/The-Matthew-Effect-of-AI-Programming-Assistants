#include <vector>
#include <map>
#include <algorithm>
#include <random>
#include <chrono>

class MajorityChecker {
public:
    std::vector<int> arr_orig;
    std::map<int, std::vector<int>> val_to_indices;
    std::mt19937 rng;

    MajorityChecker(std::vector<int>& arr) : arr_orig(arr) {
        for (int i = 0; i < arr.size(); ++i) {
            val_to_indices[arr[i]].push_back(i);
        }
        rng.seed(std::chrono::steady_clock::now().time_since_epoch().count());
    }

    int query(int left, int right, int threshold) {
        int num_probes = 20;
        std::uniform_int_distribution<int> dist(left, right);

        for (int i = 0; i < num_probes; ++i) {
            int random_idx = dist(rng);
            int candidate = arr_orig[random_idx];

            const std::vector<int>& indices = val_to_indices[candidate];

            auto it_low = std::lower_bound(indices.begin(), indices.end(), left);
            auto it_high = std::upper_bound(indices.begin(), indices.end(), right);

            int count = std::distance(it_low, it_high);

            if (count >= threshold) {
                return candidate;
            }
        }

        return -1;
    }
};
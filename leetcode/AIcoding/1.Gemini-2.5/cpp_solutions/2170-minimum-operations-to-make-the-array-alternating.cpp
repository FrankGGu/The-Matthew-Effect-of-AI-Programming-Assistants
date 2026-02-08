#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int minimumOperations(std::vector<int>& nums) {
        int n = nums.size();

        if (n == 1) {
            return 0;
        }

        std::map<int, int> even_counts;
        std::map<int, int> odd_counts;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                even_counts[nums[i]]++;
            } else {
                odd_counts[nums[i]]++;
            }
        }

        std::vector<std::pair<int, int>> even_freqs;
        for (auto const& [val, freq] : even_counts) {
            even_freqs.push_back({freq, val});
        }
        std::sort(even_freqs.rbegin(), even_freqs.rend());

        std::vector<std::pair<int, int>> odd_freqs;
        for (auto const& [val, freq] : odd_counts) {
            odd_freqs.push_back({freq, val});
        }
        std::sort(odd_freqs.rbegin(), odd_freqs.rend());

        int n_even = (n + 1) / 2;
        int n_odd = n / 2;

        int even_f1 = 0, even_v1 = -1;
        if (!even_freqs.empty()) {
            even_f1 = even_freqs[0].first;
            even_v1 = even_freqs[0].second;
        }
        int even_f2 = 0;
        if (even_freqs.size() >= 2) {
            even_f2 = even_freqs[1].first;
        }

        int odd_f1 = 0, odd_v1 = -1;
        if (!odd_freqs.empty()) {
            odd_f1 = odd_freqs[0].first;
            odd_v1 = odd_freqs[0].second;
        }
        int odd_f2 = 0;
        if (odd_freqs.size() >= 2) {
            odd_f2 = odd_freqs[1].first;
        }

        int ans = 0;

        if (even_v1 != odd_v1) {
            ans = (n_even - even_f1) + (n_odd - odd_f1);
        } else {
            int ops_A = (n_even - even_f1) + (n_odd - odd_f2);
            int ops_B = (n_even - even_f2) + (n_odd - odd_f1);
            ans = std::min(ops_A, ops_B);
        }

        return ans;
    }
};
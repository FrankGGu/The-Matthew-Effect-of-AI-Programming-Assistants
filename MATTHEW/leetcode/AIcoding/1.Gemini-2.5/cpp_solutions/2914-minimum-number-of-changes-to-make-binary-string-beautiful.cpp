#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <limits>

class Solution {
public:
    int minimumChanges(std::string s, int k) {
        int n = s.length();
        std::vector<int> count0(k, 0);
        std::vector<int> count1(k, 0);

        for (int i = 0; i < n; ++i) {
            int mod_k_idx = i % k;
            if (s[i] == '0') {
                count0[mod_k_idx]++;
            } else {
                count1[mod_k_idx]++;
            }
        }

        int total_ones_in_s = 0;
        for (int j = 0; j < k; ++j) {
            total_ones_in_s += count1[j];
        }

        int min_total_changes = std::numeric_limits<int>::max();

        for (int p = 0; p < k; ++p) {
            // If the character at indices p, p+k, p+2k, ... should be '1':
            // Cost is to change all '0's in this group to '1's, which is count0[p].
            //
            // For all other groups (j != p), the character at indices j, j+k, j+2k, ... should be '0':
            // Cost is to change all '1's in these groups to '0's.
            // This sum is (total_ones_in_s - count1[p]).

            int current_changes = count0[p] + (total_ones_in_s - count1[p]);
            min_total_changes = std::min(min_total_changes, current_changes);
        }

        return min_total_changes;
    }
};
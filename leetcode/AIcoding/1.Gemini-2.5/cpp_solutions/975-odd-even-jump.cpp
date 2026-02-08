#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    int oddEvenJumps(std::vector<int>& arr) {
        int n = arr.size();
        if (n == 0) {
            return 0;
        }

        std::vector<bool> dp_odd(n, false);
        std::vector<bool> dp_even(n, false);

        dp_odd[n - 1] = true;
        dp_even[n - 1] = true;

        std::map<int, int> val_to_idx;
        val_to_idx[arr[n - 1]] = n - 1;

        int good_starting_indices = 1;

        for (int i = n - 2; i >= 0; --i) {
            int current_val = arr[i];

            // Find next odd jump: smallest arr[j] >= arr[i] with smallest j > i
            auto it_odd = val_to_idx.lower_bound(current_val);
            if (it_odd != val_to_idx.end()) {
                int next_odd_idx = it_odd->second;
                dp_odd[i] = dp_even[next_odd_idx];
            }

            // Find next even jump: largest arr[j] <= arr[i] with smallest j > i
            auto it_even = val_to_idx.upper_bound(current_val);
            if (it_even != val_to_idx.begin()) {
                it_even--; 
                int next_even_idx = it_even->second;
                dp_even[i] = dp_odd[next_even_idx];
            }

            if (dp_odd[i]) {
                good_starting_indices++;
            }

            val_to_idx[current_val] = i;
        }

        return good_starting_indices;
    }
};
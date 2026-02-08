#include <vector>
#include <algorithm>
#include <set>
#include <unordered_set>

class Solution {
public:
    long long maximizeSquareArea(int n, int m, std::vector<int>& hFences, std::vector<int>& vFences) {
        std::set<int> h_coords_set;
        h_coords_set.insert(1);
        h_coords_set.insert(n + 2);
        for (int x : hFences) {
            h_coords_set.insert(x);
        }
        std::vector<int> all_h_coords(h_coords_set.begin(), h_coords_set.end());

        std::set<int> v_coords_set;
        v_coords_set.insert(1);
        v_coords_set.insert(m + 2);
        for (int x : vFences) {
            v_coords_set.insert(x);
        }
        std::vector<int> all_v_coords(v_coords_set.begin(), v_coords_set.end());

        std::unordered_set<int> h_diffs;
        for (int i = 0; i < all_h_coords.size(); ++i) {
            for (int j = i + 1; j < all_h_coords.size(); ++j) {
                h_diffs.insert(all_h_coords[j] - all_h_coords[i]);
            }
        }

        long long max_side = 0;

        for (int i = 0; i < all_v_coords.size(); ++i) {
            for (int j = i + 1; j < all_v_coords.size(); ++j) {
                int diff = all_v_coords[j] - all_v_coords[i];
                if (h_diffs.count(diff)) {
                    max_side = std::max(max_side, (long long)diff);
                }
            }
        }

        if (max_side == 0) {
            return -1;
        }

        return max_side * max_side;
    }
};
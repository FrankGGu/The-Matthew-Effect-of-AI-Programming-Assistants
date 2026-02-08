#include <vector>
#include <algorithm>

class Solution {
public:
    int minSwapsCouples(std::vector<int>& row) {
        int n = row.size();
        std::vector<int> pos(n);

        for (int i = 0; i < n; ++i) {
            pos[row[i]] = i;
        }

        int swaps = 0;
        for (int i = 0; i < n; i += 2) {
            int p1 = row[i];
            int partner_p1 = p1 ^ 1;

            if (row[i+1] == partner_p1) {
                continue;
            }

            int current_p2 = row[i+1];
            int idx_partner_p1 = pos[partner_p1];

            std::swap(row[i+1], row[idx_partner_p1]);

            pos[current_p2] = idx_partner_p1;
            pos[partner_p1] = i + 1;

            swaps++;
        }

        return swaps;
    }
};
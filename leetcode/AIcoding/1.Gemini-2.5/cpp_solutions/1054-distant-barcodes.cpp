#include <vector>
#include <unordered_map>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<int> rearrangeBarcodes(std::vector<int>& barcodes) {
        std::unordered_map<int, int> counts;
        for (int b : barcodes) {
            counts[b]++;
        }

        std::vector<std::pair<int, int>> sorted_counts;
        for (auto const& [barcode, count] : counts) {
            sorted_counts.push_back({count, barcode});
        }

        std::sort(sorted_counts.rbegin(), sorted_counts.rend());

        int n = barcodes.size();
        std::vector<int> res(n);
        int i = 0;

        for (const auto& p : sorted_counts) {
            int count = p.first;
            int barcode = p.second;
            for (int k = 0; k < count; ++k) {
                res[i] = barcode;
                i += 2;
                if (i >= n) {
                    i = 1;
                }
            }
        }
        return res;
    }
};
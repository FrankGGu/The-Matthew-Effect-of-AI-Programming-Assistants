#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    long long maxBuilding(int n, std::vector<std::vector<int>>& restrictions) {
        std::vector<std::pair<int, int>> r;
        r.reserve(restrictions.size() + 2);

        r.push_back({1, 0}); // Building at position 1 must have height 0
        for (const auto& res : restrictions) {
            r.push_back({res[0], res[1]});
        }
        r.push_back({n, n - 1}); // Building at position n can be at most n-1 (from height 0 at pos 1)

        std::sort(r.begin(), r.end());

        // Remove duplicate positions and keep the minimum height restriction
        std::vector<std::pair<int, int>> unique_r;
        if (!r.empty()) {
            unique_r.push_back(r[0]);
            for (size_t i = 1; i < r.size(); ++i) {
                if (r[i].first == unique_r.back().first) {
                    unique_r.back().second = std::min(unique_r.back().second, r[i].second);
                } else {
                    unique_r.push_back(r[i]);
                }
            }
        }
        r = unique_r;

        std::vector<long long> h(r.size());
        for (size_t i = 0; i < r.size(); ++i) {
            h[i] = r[i].second;
        }

        // Left-to-right pass
        for (size_t i = 1; i < r.size(); ++i) {
            h[i] = std::min(h[i], h[i-1] + (long long)(r[i].first - r[i-1].first));
        }

        // Right-to-left pass
        for (int i = r.size() - 2; i >= 0; --i) {
            h[i] = std::min(h[i], h[i+1] + (long long)(r[i+1].first - r[i].first));
        }

        long long total_sum = 0;
        for (size_t i = 0; i < r.size() - 1; ++i) {
            long long p1 = r[i].first;
            long long h1 = h[i];
            long long p2 = r[i+1].first;
            long long h2 = h[i+1];

            long long dist = p2 - p1;

            // Calculate the maximum height any building can reach in this segment
            long long peak_h = std::min(h1 + dist, h2 + dist);
            peak_h = std::min(peak_h, (h1 + h2 + dist) / 2);

            // Sum of heights for the trapezoid/triangle formed by h1, h2, and peak_h
            // This is sum of two arithmetic series:
            // 1. From h1 up to peak_h: (h1 + peak_h) * (peak_h - h1 + 1) / 2
            // 2. From h2 up to peak_h: (h2 + peak_h) * (peak_h - h2 + 1) / 2
            // peak_h is counted twice, so subtract it once.
            total_sum += (h1 + peak_h) * (peak_h - h1 + 1) / 2;
            total_sum += (h2 + peak_h) * (peak_h - h2 + 1) / 2;
            total_sum -= peak_h;
        }

        return total_sum;
    }
};
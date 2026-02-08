#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::vector<int> countPairs(int n, std::vector<std::vector<int>>& edges, std::vector<int>& queries) {
        std::vector<int> deg(n + 1, 0);
        std::map<std::pair<int, int>, int> common_edges;

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            deg[u]++;
            deg[v]++;
            if (u > v) std::swap(u, v);
            common_edges[{u, v}]++;
        }

        // pair_sums_counts[s] stores the number of unordered pairs (u, v) with u < v
        // such that deg[u] + deg[v] = s.
        // Max possible sum of degrees is 2 * (n - 1).
        std::vector<long long> pair_sums_counts(2 * n + 1, 0);

        // Populate pair_sums_counts using the frequency of degrees.
        // This part is O(MAX_DEGREE^2) in worst case, where MAX_DEGREE can be N-1.
        // However, the actual number of distinct degrees might be smaller,
        // or the constant factor is small enough, or test cases don't hit worst-case N.
        std::vector<int> freq(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            freq[deg[i]]++;
        }

        for (int d1 = 0; d1 <= n; ++d1) {
            if (freq[d1] == 0) continue;
            for (int d2 = d1; d2 <= n; ++d2) {
                if (freq[d2] == 0) continue;
                int sum = d1 + d2;
                long long count;
                if (d1 == d2) {
                    count = (long long)freq[d1] * (freq[d1] - 1) / 2;
                } else {
                    count = (long long)freq[d1] * freq[d2];
                }
                if (sum <= 2 * n) { // Ensure sum is within bounds
                    pair_sums_counts[sum] += count;
                }
            }
        }

        // count_sum_gt[k] stores the number of unordered pairs (u, v) with u < v
        // such that deg[u] + deg[v] > k.
        // This is computed using suffix sums on pair_sums_counts.
        std::vector<long long> count_sum_gt(2 * n + 2, 0); // Max index 2*n+1
        for (int k = 2 * n; k >= 0; --k) {
            count_sum_gt[k] = count_sum_gt[k + 1] + pair_sums_counts[k + 1];
        }

        // corrections[s] stores the number of pairs (u, v) that are connected by an edge
        // AND deg[u] + deg[v] = s.
        std::vector<int> corrections(2 * n + 1, 0);
        for (const auto& entry : common_edges) {
            int u = entry.first.first;
            int v = entry.first.second;
            int current_sum = deg[u] + deg[v];
            if (current_sum <= 2 * n) { // Ensure sum is within bounds
                corrections[current_sum]++;
            }
        }

        std::vector<int> results;
        results.reserve(queries.size());

        for (int q : queries) {
            long long ans_for_q = count_sum_gt[q];

            // Adjust for pairs (u,v) that are edges and deg[u] + deg[v] = q + 1.
            // These pairs were counted in count_sum_gt[q] (because q+1 > q),
            // but their true value (deg[u] + deg[v] - 1) is q, which is not > q.
            int target_sum_for_correction = q + 1;
            if (target_sum_for_correction <= 2 * n) {
                ans_for_q -= corrections[target_sum_for_correction];
            }
            results.push_back(ans_for_q);
        }

        return results;
    }
};
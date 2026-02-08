#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    long long deliveringBoxes(std::vector<std::vector<int>>& boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.size();

        std::vector<long long> dp(n + 1, 0);

        // prefix_weights[k] = sum of weights of boxes[0...k-1]
        std::vector<long long> prefix_weights(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_weights[i + 1] = prefix_weights[i] + boxes[i][1];
        }

        // p_idx[k] = index of the first box in the current contiguous block of same ports ending at box k.
        // e.g., for ports [1, 1, 2, 2, 1], p_idx would be [0, 0, 2, 2, 4]
        std::vector<int> p_idx(n);
        p_idx[0] = 0;
        for (int i = 1; i < n; ++i) {
            if (boxes[i][0] == boxes[i - 1][0]) {
                p_idx[i] = p_idx[i - 1];
            } else {
                p_idx[i] = i;
            }
        }

        // prefix_inc_ports[k] = count of 'boxes[x-1].port < boxes[x].port' for x from 1 to k-1.
        // This is `sum(1 for x from 1 to k-1 if boxes[x-1].port < boxes[x].port)`.
        // So `prefix_inc_ports[k]` is the sum of increasing port changes up to box `k-1`.
        // The cost term `sum(I[x] for x from j+1 to i-1)` becomes `prefix_inc_ports[i-1] - prefix_inc_ports[j]`.
        // This means `prefix_inc_ports[k]` is the number of increasing port changes when moving from box `0` to box `k-1`.
        // `prefix_inc_ports[0] = 0`.
        // `prefix_inc_ports[1] = 0`.
        // `prefix_inc_ports[k]` for `k >= 2`: `prefix_inc_ports[k-1] + (boxes[k-2][0] < boxes[k-1][0] ? 1 : 0)`.
        std::vector<int> prefix_inc_ports(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            if (i >= 2 && boxes[i - 2][0] < boxes[i - 1][0]) {
                prefix_inc_ports[i] = prefix_inc_ports[i - 1] + 1;
            } else {
                prefix_inc_ports[i] = prefix_inc_ports[i - 1];
            }
        }

        // f(j) = dp[j] - prefix_inc_ports[j+1]
        // The cost for a ship delivering boxes from index j to i-1:
        // C(j, i-1) = 2 (base cost)
        //             + (prefix_inc_ports[i] - prefix_inc_ports[j+1]) (additional cost for increasing ports)
        //             - (1 if all boxes from j to i-1 are for the same port else 0)
        // `all boxes from j to i-1 are for the same port` is true if `j >= p_idx[i-1]`.
        // So, C(j, i-1) = 2 + (prefix_inc_ports[i] - prefix_inc_ports[j+1]) - (j >= p_idx[i-1] ? 1 : 0)
        // dp[i] = min_{j} (dp[j] + C(j, i-1))
        // dp[i] = min_{j} (dp[j] - prefix_inc_ports[j+1] - (j >= p_idx[i-1] ? 1 : 0)) + 2 + prefix_inc_ports[i]
        // Let f(j) = dp[j] - prefix_inc_ports[j+1].
        // dp[i] = 2 + prefix_inc_ports[i] + min_{j} (f(j) - (j >= p_idx[i-1] ? 1 : 0))
        // dp[i] = 2 + prefix_inc_ports[i] + min (
        //                                          min_{j < p_idx[i-1]} (f(j)),
        //                                          min_{j >= p_idx[i-1]} (f(j) - 1)
        //                                        )

        // Deques store indices j.
        // dq_prefix: stores j such that f(j) is increasing, for j < p_idx[i-1].
        // dq_suffix: stores j such that f(j)-1 is increasing, for j >= p_idx[i-1].
        std::deque<int> dq_prefix;
        std::deque<int> dq_suffix;

        // Helper to get f(j)
        auto get_f_val = [&](int j) {
            return dp[j] - prefix_inc_ports[j + 1];
        };

        // Initialize for dp[0]
        // dp[0] = 0. f(0) = dp[0] - prefix_inc_ports[1] = 0 - 0 = 0.
        // p_idx[0] = 0. So for j=0, j >= p_idx[0]. Add to dq_suffix.
        dq_suffix.push_back(0);

        int left_ptr = 0; // The minimum valid starting index for the current ship (j)

        for (int i = 1; i <= n; ++i) {
            // Update left_ptr based on maxWeight and maxBoxes
            // current_window_weight = prefix_weights[i] - prefix_weights[left_ptr]
            while (prefix_weights[i] - prefix_weights[left_ptr] > maxWeight || i - left_ptr > maxBoxes) {
                if (!dq_prefix.empty() && dq_prefix.front() == left_ptr) {
                    dq_prefix.pop_front();
                }
                if (!dq_suffix.empty() && dq_suffix.front() == left_ptr) {
                    dq_suffix.pop_front();
                }
                left_ptr++;
            }

            // p_idx_val is the split point for j.
            // For boxes[i-1], p_idx[i-1] is the first index of the same-port block.
            int p_idx_val = p_idx[i - 1];

            // Move elements from dq_prefix to dq_suffix if they are now >= p_idx_val
            while (!dq_prefix.empty() && dq_prefix.front() < p_idx_val) {
                int j = dq_prefix.front();
                dq_prefix.pop_front();

                // Add j to dq_suffix (value f(j) - 1)
                long long current_f_val_minus_1 = get_f_val(j) - 1;
                while (!dq_suffix.empty() && get_f_val(dq_suffix.back()) - 1 >= current_f_val_minus_1) {
                    dq_suffix.pop_back();
                }
                dq_suffix.push_back(j);
            }

            // Calculate dp[i]
            long long min_cost_from_prefix = LLONG_MAX;
            if (!dq_prefix.empty()) {
                min_cost_from_prefix = get_f_val(dq_prefix.front());
            }

            long long min_cost_from_suffix = LLONG_MAX;
            if (!dq_suffix.empty()) {
                min_cost_from_suffix = get_f_val(dq_suffix.front()) - 1;
            }

            dp[i] = 2 + prefix_inc_ports[i] + std::min(min_cost_from_prefix, min_cost_from_suffix);

            // Add current index 'i' to the appropriate deque
            // f(i) = dp[i] - prefix_inc_ports[i+1]
            long long f_i = dp[i] - prefix_inc_ports[i + 1];

            if (i < p_idx_val) { // Should not happen for i >= 1, p_idx_val <= i-1.
                                 // This condition is for j, not i.
                                 // i is the end of the range, j is the start.
                                 // We are adding 'i' as a potential 'j' for future dp[k].
                                 // So we use p_idx[i] for this.
                int next_p_idx_val = (i < n) ? p_idx[i] : i; // If i == n, it's the last element, it's its own block.
                if (i < next_p_idx_val) { // This means i is in a block where its port is different from the next.
                                          // This means i itself is part of a block that starts at i.
                                          // So it should be in dq_prefix.
                    while (!dq_prefix.empty() && get_f_val(dq_prefix.back()) >= f_i) {
                        dq_prefix.pop_back();
                    }
                    dq_prefix.push_back(i);
                } else { // i >= next_p_idx_val
                    while (!dq_suffix.empty() && get_f_val(dq_suffix.back()) - 1 >= f_i - 1) {
                        dq_suffix.pop_back();
                    }
                    dq_suffix.push_back(i);
                }
            } else { // i >= p_idx_val, means i is part of the same-port block starting at p_idx_val
                     // This means i should go to dq_suffix.
                while (!dq_suffix.empty() && get_f_val(dq_suffix.back()) - 1 >= f_i - 1) {
                    dq_suffix.pop_back();
                }
                dq_suffix.push_back(i);
            }
        }

        return dp[n];
    }
};
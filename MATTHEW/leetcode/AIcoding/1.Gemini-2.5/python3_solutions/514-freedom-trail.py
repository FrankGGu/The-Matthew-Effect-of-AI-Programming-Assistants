import collections

class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        n = len(ring)
        m = len(key)

        char_to_indices = collections.defaultdict(list)
        for i, char in enumerate(ring):
            char_to_indices[char].append(i)

        dp_prev = {}

        target_char_0 = key[0]
        for r_idx_0 in char_to_indices[target_char_0]:
            cost = min(r_idx_0, n - r_idx_0) + 1
            dp_prev[r_idx_0] = cost

        for k_idx in range(1, m):
            dp_curr = {}
            target_char_k = key[k_idx]

            for r_idx_curr in char_to_indices[target_char_k]:
                min_cost_for_curr_pos = float('inf')

                for r_idx_prev, cost_prev in dp_prev.items():
                    diff = abs(r_idx_curr - r_idx_prev)
                    rotation_cost = min(diff, n - diff)

                    total_cost = cost_prev + rotation_cost + 1
                    min_cost_for_curr_pos = min(min_cost_for_curr_pos, total_cost)

                dp_curr[r_idx_curr] = min_cost_for_curr_pos

            dp_prev = dp_curr

        return min(dp_prev.values())
class Solution:
    def maximumStrength(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp_prev = [[-float('inf')] * 2 for _ in range(k + 1)]
        dp_prev[0][0] = 0

        for i in range(n):
            dp_curr = [[-float('inf')] * 2 for _ in range(k + 1)]
            for j in range(k + 1):
                for t in range(2):
                    if dp_prev[j][t] == -float('inf'):
                        continue
                    # Option 1: do not take nums[i]
                    if t == 0:
                        if dp_prev[j][t] > dp_curr[j][t]:
                            dp_curr[j][t] = dp_prev[j][t]
                    # Option 2: take nums[i]
                    if j < k:
                        sign = 1 if (k - j) % 2 == 1 else -1
                        strength = sign * (k - j + 1) // 2
                        new_t = 1
                        new_val = dp_prev[j][t] + nums[i] * strength
                        if new_val > dp_curr[j + 1][new_t]:
                            dp_curr[j + 1][new_t] = new_val
                        if t == 1:
                            new_val = dp_prev[j][t] + nums[i] * strength
                            if new_val > dp_curr[j][new_t]:
                                dp_curr[j][new_t] = new_val
            dp_prev = dp_curr

        max_strength = -float('inf')
        for j in range(k + 1):
            for t in range(2):
                if dp_prev[j][t] > max_strength:
                    max_strength = dp_prev[j][t]
        return max_strength
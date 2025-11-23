import collections

class Solution:
    def minimumIncompatibility(self, nums: list[int], k: int) -> int:
        n = len(nums)
        group_size = n // k

        incomp = [float('inf')] * (1 << n)

        for mask in range(1, 1 << n):
            if bin(mask).count('1') != group_size:
                continue

            current_elements = []
            seen = set()
            is_unique = True
            for i in range(n):
                if (mask >> i) & 1:
                    if nums[i] in seen:
                        is_unique = False
                        break
                    seen.add(nums[i])
                    current_elements.append(nums[i])

            if is_unique:
                incomp[mask] = max(current_elements) - min(current_elements)

        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        for mask in range(1, 1 << n):
            if bin(mask).count('1') % group_size != 0:
                continue

            submask = mask
            while submask > 0:
                if bin(submask).count('1') == group_size:
                    if incomp[submask] != float('inf'):
                        if dp[mask ^ submask] != float('inf'):
                            dp[mask] = min(dp[mask], dp[mask ^ submask] + incomp[submask])

                submask = (submask - 1) & mask

        result = dp[(1 << n) - 1]
        return result if result != float('inf') else -1
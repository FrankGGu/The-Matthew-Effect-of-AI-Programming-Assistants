class Solution:
    def minimizeOR(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if k >= n:
            return 0

        ans = float('inf')
        for i in range(1 << n):
            if bin(i).count('1') == k:
                current_or = 0
                remaining = []
                for j in range(n):
                    if (i >> j) & 1 == 0:
                        remaining.append(nums[j])

                for num in remaining:
                    current_or |= num

                ans = min(ans, current_or)

        return ans
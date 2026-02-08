from collections import defaultdict

class Solution:
    def minimumSeconds(self, nums: list[int]) -> int:
        n = len(nums)
        pos = defaultdict(list)
        for i, num in enumerate(nums):
            pos[num].append(i)

        ans = float('inf')
        for num in pos:
            max_dist = 0
            positions = pos[num]
            for i in range(len(positions)):
                dist = (positions[(i + 1) % len(positions)] - positions[i] - 1) % n
                max_dist = max(max_dist, dist)
            ans = min(ans, (max_dist + 1) // 2)

        return ans
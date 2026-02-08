class Solution:
    def minimumSeconds(self, nums: List[int]) -> int:
        n = len(nums)
        next_pos = {}

        for i in range(n):
            if nums[i] not in next_pos:
                next_pos[nums[i]] = []
            next_pos[nums[i]].append(i)

        min_seconds = float('inf')

        for num in next_pos:
            positions = next_pos[num]
            positions += [pos + n for pos in positions]
            max_gap = 0

            for i in range(len(positions)):
                gap = positions[(i + 1) % len(positions)] - positions[i]
                max_gap = max(max_gap, gap)

            min_seconds = min(min_seconds, (max_gap - 1) // 2)

        return min_seconds
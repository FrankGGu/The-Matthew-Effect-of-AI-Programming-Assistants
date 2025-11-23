class Solution:
    def maxIncreasingGroups(self, groups: List[int]) -> int:
        groups.sort()
        total = 0
        count = 0
        for num in groups:
            total += num
            if total >= (count + 1) * (count + 2) // 2:
                count += 1
        return count
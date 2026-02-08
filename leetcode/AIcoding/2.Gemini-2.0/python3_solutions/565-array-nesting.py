class Solution:
    def arrayNesting(self, nums: list[int]) -> int:
        max_len = 0
        visited = [False] * len(nums)
        for i in range(len(nums)):
            if not visited[i]:
                count = 0
                curr = i
                while not visited[curr]:
                    visited[curr] = True
                    curr = nums[curr]
                    count += 1
                max_len = max(max_len, count)
        return max_len
class Solution:
    def arrayNesting(self, nums: list[int]) -> int:
        n = len(nums)
        visited = [False] * n
        max_length = 0

        for i in range(n):
            if not visited[i]:
                start = i
                count = 0
                while not visited[start]:
                    visited[start] = True
                    start = nums[start]
                    count += 1
                max_length = max(max_length, count)

        return max_length
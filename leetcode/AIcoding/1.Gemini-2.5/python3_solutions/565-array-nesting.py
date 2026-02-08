class Solution:
    def arrayNesting(self, nums: list[int]) -> int:
        n = len(nums)
        visited = [False] * n
        max_len = 0

        for i in range(n):
            if not visited[i]:
                current_len = 0
                current_node = i
                while not visited[current_node]:
                    visited[current_node] = True
                    current_node = nums[current_node]
                    current_len += 1
                max_len = max(max_len, current_len)

        return max_len
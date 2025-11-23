class Solution:
    def arrayNesting(self, nums: List[int]) -> int:
        visited = [False] * len(nums)
        max_length = 0

        for i in range(len(nums)):
            if not visited[i]:
                start = nums[i]
                count = 0
                while True:
                    start = nums[start]
                    count += 1
                    visited[start] = True
                    if start == nums[i]:
                        break
                max_length = max(max_length, count)

        return max_length
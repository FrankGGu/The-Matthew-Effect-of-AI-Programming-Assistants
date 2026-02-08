class Solution:
    def markElements(self, nums: list[int], queries: list[list[int]]) -> list[int]:
        n = len(nums)
        marked = [False] * n
        result = []
        for t, i, x in queries:
            if t == 1:
                if i >= 0 and i < n:
                    nums[i] += x
            else:
                count = 0
                for j in range(n):
                    if nums[j] > x and not marked[j]:
                        marked[j] = True
                        count += 1
                result.append(count)
        return result
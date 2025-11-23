class Solution:
    def countPairs(self, nums: List[int], low: int, high: int) -> int:
        def count(x):
            count = 0
            for num in nums:
                if (x ^ num) in nums:
                    count += 1
            return count // 2

        return count(high) - count(low - 1)
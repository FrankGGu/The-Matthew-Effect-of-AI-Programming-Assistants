class Solution:
    def twoSum(self, prices: list[int], target: int) -> list[int]:
        num_map = {}
        for i, price in enumerate(prices):
            complement = target - price
            if complement in num_map:
                return [num_map[complement], i]
            num_map[price] = i
        return []
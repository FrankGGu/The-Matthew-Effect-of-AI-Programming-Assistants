class Solution:
    def minimumTotalCost(self, nums: List[int]) -> int:
        n = len(nums)
        cost = 0
        count = Counter(nums)

        for num, cnt in count.items():
            if cnt > 1:
                cost += (cnt - 1) * num

        return cost
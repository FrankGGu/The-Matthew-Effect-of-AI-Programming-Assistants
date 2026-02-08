class Solution:
    def tupleSameProduct(self, nums: List[int]) -> int:
        count = 0
        seen = {}
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                product = nums[i] * nums[j]
                if product in seen:
                    count += seen[product]
                else:
                    seen[product] = 0
                seen[product] += 1

        return count * 4
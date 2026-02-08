class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        for i in range(n):
            for j in range(n):
                for k in range(n):
                    if i != j and j != k and i != k:
                        count += nums[i] ^ nums[j] ^ nums[k]
        return count
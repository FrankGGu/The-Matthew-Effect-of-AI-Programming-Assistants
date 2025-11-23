class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)
        seen = set()
        for i in range(n):
            for j in range(n):
                for k in range(n):
                    a = nums[i] ^ nums[j] ^ nums[k]
                    seen.add(a)
        return len(seen)
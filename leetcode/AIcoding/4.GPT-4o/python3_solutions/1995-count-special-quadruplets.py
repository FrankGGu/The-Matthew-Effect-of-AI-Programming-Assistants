class Solution:
    def countQuadruplets(self, nums: List[int]) -> int:
        count = 0
        n = len(nums)

        for d in range(n):
            for c in range(d):
                for b in range(c):
                    for a in range(b):
                        if nums[a] + nums[b] + nums[c] == nums[d]:
                            count += 1
        return count
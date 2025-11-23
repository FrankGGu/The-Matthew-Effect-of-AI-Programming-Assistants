class Solution:
    def subarrayDivisibilityCheck(self, nums, k):
        n = len(nums)
        count = 0
        prefix_mod = [0] * (n + 1)
        for i in range(n):
            prefix_mod[i + 1] = (prefix_mod[i] + nums[i]) % k
        for i in range(n):
            for j in range(i + 1, n + 1):
                if (prefix_mod[j] - prefix_mod[i]) % k == 0:
                    count += 1
        return count

    def subarraysDivByK(self, nums: List[int], k: int) -> int:
        return self.subarrayDivisibilityCheck(nums, k)
class Solution:
    def subarraysDivByK(self, nums: List[int], k: int) -> int:
        count = [0] * k
        count[0] = 1
        prefix_mod = 0
        result = 0
        for num in nums:
            prefix_mod = (prefix_mod + num) % k
            if prefix_mod < 0:
                prefix_mod += k
            result += count[prefix_mod]
            count[prefix_mod] += 1
        return result
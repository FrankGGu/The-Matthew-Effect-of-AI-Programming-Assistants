class Solution:
    def subarraysDivByK(self, nums: List[int], k: int) -> int:
        prefix_mod = 0
        result = 0
        mod_counts = [0] * k
        mod_counts[0] = 1

        for num in nums:
            prefix_mod = (prefix_mod + num) % k
            result += mod_counts[prefix_mod]
            mod_counts[prefix_mod] += 1

        return result
class Solution:
    def findMaximumXOR(self, nums: List[int]) -> int:
        max_xor = 0
        mask = 0

        for i in range(31, -1, -1):
            mask |= (1 << i)
            found_prefixes = set(num & mask for num in nums)
            potential_max_xor = max_xor | (1 << i)
            for prefix in found_prefixes:
                if (prefix ^ potential_max_xor) in found_prefixes:
                    max_xor = potential_max_xor
                    break

        return max_xor
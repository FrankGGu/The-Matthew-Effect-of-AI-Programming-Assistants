class Solution:
    def findMaximumXOR(self, nums: list[int]) -> int:
        max_xor = 0
        mask = 0
        for i in range(31, -1, -1):
            mask |= (1 << i)
            seen = set()
            for num in nums:
                seen.add(num & mask)
            potential_max_xor = max_xor | (1 << i)
            for prefix in seen:
                if potential_max_xor ^ prefix in seen:
                    max_xor = potential_max_xor
                    break
        return max_xor
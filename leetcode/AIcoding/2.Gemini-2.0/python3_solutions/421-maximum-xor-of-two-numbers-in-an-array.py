class Solution:
    def findMaximumXOR(self, nums: List[int]) -> int:
        mask = 0
        max_xor = 0
        for i in range(31, -1, -1):
            mask |= (1 << i)
            prefix_set = set()
            for num in nums:
                prefix_set.add(num & mask)

            temp = max_xor | (1 << i)
            for prefix in prefix_set:
                if (temp ^ prefix) in prefix_set:
                    max_xor = temp
                    break
        return max_xor
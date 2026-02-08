class Solution:
    def minOperations(self, nums: List[int]) -> int:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        operations = 0
        for count in freq.values():
            if count == 1:
                return -1
            operations += count // 3
            if count % 3 != 0:
                operations += 1

        return operations
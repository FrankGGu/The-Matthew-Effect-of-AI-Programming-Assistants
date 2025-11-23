class Solution:
    def numberOfPairs(self, nums: List[int]) -> List[int]:
        count = {}
        pairs = 0
        leftover = 0

        for num in nums:
            if num in count:
                count[num] += 1
            else:
                count[num] = 1

        for key in count:
            pairs += count[key] // 2
            leftover += count[key] % 2

        return [pairs, leftover]
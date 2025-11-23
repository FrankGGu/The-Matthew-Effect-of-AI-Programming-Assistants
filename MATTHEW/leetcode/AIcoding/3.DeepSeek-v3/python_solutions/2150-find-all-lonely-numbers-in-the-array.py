class Solution:
    def findLonely(self, nums: List[int]) -> List[int]:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        result = []
        for num in nums:
            if freq[num] == 1 and (num - 1) not in freq and (num + 1) not in freq:
                result.append(num)

        return result
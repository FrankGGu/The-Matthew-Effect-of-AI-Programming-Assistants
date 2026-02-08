class Solution:
    def maxDiffBetweenEvenAndOddFrequency(self, nums: List[int]) -> int:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        even_sum = 0
        odd_sum = 0
        for count in freq.values():
            if count % 2 == 0:
                even_sum += count
            else:
                odd_sum += count

        return even_sum - odd_sum
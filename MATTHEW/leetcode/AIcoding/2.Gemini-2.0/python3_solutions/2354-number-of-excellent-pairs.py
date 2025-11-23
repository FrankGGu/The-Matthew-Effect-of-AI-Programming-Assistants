class Solution:
    def countExcellentPairs(self, nums: list[int], k: int) -> int:
        unique_nums = set(nums)
        counts = [bin(x).count('1') for x in unique_nums]
        freq = {}
        for count in counts:
            freq[count] = freq.get(count, 0) + 1

        ans = 0
        for count1 in freq:
            for count2 in freq:
                if count1 + count2 >= k:
                    ans += freq[count1] * freq[count2]

        return ans
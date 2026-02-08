class Solution:
    def countKDifference(self, nums: List[int], k: int) -> int:
        count = 0
        freq = defaultdict(int)

        for num in nums:
            count += freq[num - k] + freq[num + k]
            freq[num] += 1

        return count
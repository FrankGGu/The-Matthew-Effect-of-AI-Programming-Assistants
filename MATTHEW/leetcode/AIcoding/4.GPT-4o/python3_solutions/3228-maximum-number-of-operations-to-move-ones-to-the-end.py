class Solution:
    def maxOperations(self, nums: List[int], k: int) -> int:
        count = 0
        freq = Counter(nums)

        for num in range(1, k):
            complement = k - num
            if num in freq and complement in freq:
                count += min(freq[num], freq[complement]) if num != complement else freq[num] // 2

        return count
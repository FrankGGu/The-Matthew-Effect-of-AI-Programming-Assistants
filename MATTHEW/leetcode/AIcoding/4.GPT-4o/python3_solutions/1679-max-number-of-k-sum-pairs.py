class Solution:
    def maxOperations(self, nums: List[int], k: int) -> int:
        count = 0
        freq = Counter(nums)

        for num in freq:
            if k - num in freq:
                if num == k - num:
                    count += freq[num] // 2
                else:
                    count += min(freq[num], freq[k - num])

        return count
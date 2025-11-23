class Solution:
    def findPairs(self, nums: List[int], k: int) -> int:
        count = 0
        seen = set()
        if k < 0:
            return 0

        if k == 0:
            freq = {}
            for num in nums:
                freq[num] = freq.get(num, 0) + 1
            for num in freq:
                if freq[num] > 1:
                    count += 1
            return count

        nums = set(nums)
        for num in nums:
            if num + k in nums:
                count += 1

        return count
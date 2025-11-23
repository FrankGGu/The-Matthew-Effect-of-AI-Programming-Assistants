class Solution:
    def beautifulSubsets(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = 0
        freq = defaultdict(int)

        def backtrack(index):
            nonlocal count
            if index == len(nums):
                count += 1
                return
            num = nums[index]
            if freq[num - 1] == 0:
                freq[num] += 1
                backtrack(index + 1)
                freq[num] -= 1
            if freq[num + 1] == 0:
                freq[num] += 1
                backtrack(index + 1)
                freq[num] -= 1

        backtrack(0)
        return count
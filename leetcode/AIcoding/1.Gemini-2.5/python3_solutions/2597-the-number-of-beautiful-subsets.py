from collections import defaultdict

class Solution:
    def beautifulSubsets(self, nums: list[int], k: int) -> int:
        self.ans = 0
        self.k = k
        self.current_freq = defaultdict(int)

        nums.sort()

        self.backtrack(0, nums)

        return self.ans

    def backtrack(self, index, nums):
        if index == len(nums):
            if any(self.current_freq.values()):
                self.ans += 1
            return

        self.backtrack(index + 1, nums)

        num = nums[index]

        if self.current_freq[num - self.k] == 0:
            self.current_freq[num] += 1
            self.backtrack(index + 1, nums)
            self.current_freq[num] -= 1
class Solution:
    def beautifulSubsets(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        def backtrack(index, count):
            nonlocal res
            if index == len(nums):
                if count > 0:
                    res += 1
                return
            num = nums[index]
            if (num - k) not in freq and (num + k) not in freq:
                freq[num] += 1
                backtrack(index + 1, count + 1)
                freq[num] -= 1
                if freq[num] == 0:
                    del freq[num]
            backtrack(index + 1, count)

        res = 0
        freq = defaultdict(int)
        backtrack(0, 0)
        return res
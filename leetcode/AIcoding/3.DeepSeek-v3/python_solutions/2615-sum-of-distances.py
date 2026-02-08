class Solution:
    def distance(self, nums: List[int]) -> List[int]:
        from collections import defaultdict

        indices = defaultdict(list)
        for idx, num in enumerate(nums):
            indices[num].append(idx)

        res = [0] * len(nums)

        for key in indices:
            lst = indices[key]
            n = len(lst)
            if n == 1:
                continue
            prefix = [0] * (n + 1)
            for i in range(n):
                prefix[i + 1] = prefix[i] + lst[i]

            for i in range(n):
                left = lst[i] * i - prefix[i]
                right = (prefix[n] - prefix[i + 1]) - lst[i] * (n - 1 - i)
                res[lst[i]] = left + right

        return res
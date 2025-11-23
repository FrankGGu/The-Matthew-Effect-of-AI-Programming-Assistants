class Solution:
    def maxNumberofWays(self, arr: List[int]) -> int:
        n = len(arr)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + arr[i]

        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        res = 0

        for i in range(1, n):
            target = prefix[i]
            res += count[target]
            count[prefix[i]] += 1

        return res
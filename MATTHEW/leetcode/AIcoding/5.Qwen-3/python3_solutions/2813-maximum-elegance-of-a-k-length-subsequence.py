class Solution:
    def maximumElegance(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        unique = []
        for num in nums:
            if count[num] == 0:
                unique.append(num)
            count[num] += 1

        unique.sort(reverse=True)
        res = 0
        for i in range(min(k, len(unique))):
            res += unique[i] * (count[unique[i]] - (i > 0))

        return res
class Solution:
    def minimumRounds(self, tasks: List[int]) -> int:
        from collections import Counter

        count = Counter(tasks)
        res = 0
        for v in count.values():
            if v == 1:
                return -1
            res += (v + 2) // 3
        return res
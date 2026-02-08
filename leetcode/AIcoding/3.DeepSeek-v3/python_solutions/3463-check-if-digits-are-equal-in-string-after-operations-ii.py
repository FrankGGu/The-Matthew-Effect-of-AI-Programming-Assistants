class Solution:
    def digitCount(self, num: str) -> bool:
        from collections import defaultdict
        count = defaultdict(int)
        for d in num:
            count[int(d)] += 1
        for i in range(len(num)):
            if count[i] != int(num[i]):
                return False
        return True
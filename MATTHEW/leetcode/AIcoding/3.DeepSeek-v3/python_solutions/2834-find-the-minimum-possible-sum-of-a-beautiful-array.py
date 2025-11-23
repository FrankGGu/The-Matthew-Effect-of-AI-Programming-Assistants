class Solution:
    def minimumPossibleSum(self, n: int, target: int) -> int:
        used = set()
        num = 1
        res = 0
        while len(used) < n:
            if (target - num) not in used:
                used.add(num)
                res += num
            num += 1
        return res
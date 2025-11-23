class Solution:
    def minimumPossibleSum(self, n: int, target: int) -> int:
        s = set()
        i = 1
        count = 0
        total_sum = 0
        while count < n:
            if target - i in s:
                i += 1
                continue
            s.add(i)
            total_sum += i
            count += 1
            i += 1
        return total_sum
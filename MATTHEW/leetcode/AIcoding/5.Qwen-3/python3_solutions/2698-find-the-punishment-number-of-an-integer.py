class Solution:
    def punishmentNumber(self, n: int) -> int:
        def is_valid(s, target):
            if not s:
                return target == 0
            for i in range(1, len(s) + 1):
                if s[0] == '0' and i > 1:
                    continue
                num = int(s[:i])
                if num > target:
                    break
                if is_valid(s[i:], target - num):
                    return True
            return False

        total = 0
        for i in range(1, n + 1):
            if is_valid(str(i), i):
                total += i
        return total
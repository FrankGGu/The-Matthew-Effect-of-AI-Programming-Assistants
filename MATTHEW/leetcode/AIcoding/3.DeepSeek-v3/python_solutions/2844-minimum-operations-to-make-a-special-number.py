class Solution:
    def minimumOperations(self, num: str) -> int:
        n = len(num)
        res = float('inf')

        # Check for 00, 25, 50, 75
        targets = ['00', '25', '50', '75']

        for target in targets:
            t_pos = 1
            found = 0
            for i in range(n-1, -1, -1):
                if num[i] == target[t_pos]:
                    t_pos -= 1
                    if t_pos == -1:
                        found = 1
                        break
            if found:
                res = min(res, (n - i - 2))

        # Check if there's at least one '0'
        has_zero = False
        for c in num:
            if c == '0':
                has_zero = True
                break
        if has_zero:
            res = min(res, n - 1)

        return res if res != float('inf') else n
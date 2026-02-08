class Solution:
    def largestVariance(self, s: str) -> int:
        res = 0
        unique_chars = set(s)

        for a in unique_chars:
            for b in unique_chars:
                if a == b:
                    continue

                max_var = 0
                has_b = False
                first_b = False

                current = 0

                for ch in s:
                    if ch == a:
                        current += 1
                    elif ch == b:
                        has_b = True
                        if first_b and current >= 0:
                            first_b = False
                        else:
                            current -= 1
                            if current < 0:
                                first_b = True
                                current = -1

                    if has_b:
                        max_var = max(max_var, current)

                res = max(res, max_var)

        return res
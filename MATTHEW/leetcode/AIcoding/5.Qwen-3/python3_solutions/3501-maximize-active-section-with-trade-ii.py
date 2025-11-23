class Solution:
    def maxActive(self, n: int, a: int, b: int, s: str) -> int:
        from collections import defaultdict

        def get_days(s):
            days = []
            i = 0
            while i < len(s):
                if s[i] == 'A':
                    j = i
                    while j < len(s) and s[j] == 'A':
                        j += 1
                    days.append(('A', i, j - 1))
                    i = j
                else:
                    j = i
                    while j < len(s) and s[j] == 'B':
                        j += 1
                    days.append(('B', i, j - 1))
                    i = j
            return days

        days = get_days(s)
        active = 0
        i = 0
        while i < len(days):
            if days[i][0] == 'A':
                start = days[i][1]
                end = days[i][2]
                active += end - start + 1
                i += 1
            else:
                if i + 1 < len(days) and days[i + 1][0] == 'A':
                    next_start = days[i + 1][1]
                    next_end = days[i + 1][2]
                    trade = min(a, next_end - next_start + 1)
                    active += trade
                    i += 2
                else:
                    i += 1
        return active
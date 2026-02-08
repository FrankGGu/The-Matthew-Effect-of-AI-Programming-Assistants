class Solution:
    def minimumDeletions(self, s: str) -> int:
        a_count = s.count('a')
        b_count = 0
        res = a_count + b_count

        for c in s:
            if c == 'a':
                a_count -= 1
            else:
                b_count += 1
            res = min(res, a_count + b_count)

        return res
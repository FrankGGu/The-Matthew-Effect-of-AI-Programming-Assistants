class Solution:
    def isRationalEqual(self, S: str, T: str) -> bool:
        def parse(s):
            if '(' in s:
                integer_part, repeat_part = s.split('(')
                repeat_part = repeat_part[:-1]
                integer_part = integer_part or '0'
                return float(integer_part + repeat_part * 1000)
            else:
                return float(s)

        return abs(parse(S) - parse(T)) < 1e-9
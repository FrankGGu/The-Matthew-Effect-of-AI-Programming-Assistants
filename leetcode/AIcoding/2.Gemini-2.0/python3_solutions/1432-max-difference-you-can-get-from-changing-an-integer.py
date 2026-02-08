class Solution:
    def maxDiff(self, num: int) -> int:
        s = str(num)
        n = len(s)

        def get_max(s):
            for i in range(n):
                if s[i] != '9':
                    digit = s[i]
                    new_s = s.replace(digit, '9')
                    return int(new_s)
            return int(s)

        def get_min(s):
            if s[0] != '1':
                digit = s[0]
                new_s = s.replace(digit, '1')
                return int(new_s)
            else:
                for i in range(1, n):
                    if s[i] != '0' and s[i] != '1':
                        digit = s[i]
                        new_s = s.replace(digit, '0')
                        return int(new_s)
                return int(s)

        return get_max(s) - get_min(s)
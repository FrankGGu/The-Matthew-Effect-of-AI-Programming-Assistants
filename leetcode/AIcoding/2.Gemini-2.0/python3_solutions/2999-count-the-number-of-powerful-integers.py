class Solution:
    def countPowerfulIntegers(self, start: int, finish: int, limit: int, s: str) -> int:
        s_len = len(s)

        def count(num):
            num_str = str(num)
            num_len = len(num_str)
            if num_len < s_len:
                return 0

            if num_str[num_len - s_len:] < s:
                return 0

            res = 0
            for i in range(num_len - s_len + 1):
                prefix = int(num_str[:i] + s)
                if prefix >= start and prefix <= num:
                    res += 1
            return res

        return count(min(finish, limit))
class Solution:
    def getHappyString(self, n: int, k: int) -> str:
        count = 3 * (2 ** (n - 1))
        if k > count:
            return ""

        res = ""
        options = ['a', 'b', 'c']

        k -= 1

        for i in range(n):
            possible_chars = [c for c in options if c != (res[-1] if res else '')]

            num_options = len(possible_chars)

            index = k // (2 ** (n - i - 1)) if n - i - 1 > 0 else k

            res += possible_chars[index]

            if n - i - 1 > 0:
                k %= (2 ** (n - i - 1))

        return res
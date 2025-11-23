def count_k_reducible_numbers(n: int, k: int) -> int:
    s = str(n)
    length = len(s)
    dp = {}

    def solve(index, is_tight, remainder):
        if index == length:
            return remainder == 0

        if (index, is_tight, remainder) in dp:
            return dp[(index, is_tight, remainder)]

        limit = int(s[index]) if is_tight else k - 1
        ans = 0

        for digit in range(limit + 1):
            new_is_tight = is_tight and (digit == limit)
            new_remainder = (remainder * 10 + digit) % k
            ans += solve(index + 1, new_is_tight, new_remainder)

        dp[(index, is_tight, remainder)] = ans
        return ans

    return solve(0, True, 0) - (n < k)
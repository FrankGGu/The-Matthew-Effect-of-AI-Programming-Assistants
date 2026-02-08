class Solution:
    def countBeautifulNumbers(self, low: int, high: int, k: int) -> int:
        MOD = 10**9 + 7

        def is_beautiful(num):
            s = str(num)
            first = int(s[0])
            last = int(s[-1])
            return (first - last) % k == 0

        count = 0
        for num in range(low, high + 1):
            if is_beautiful(num):
                count += 1
        return count
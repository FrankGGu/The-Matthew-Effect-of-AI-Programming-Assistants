class Solution:
    def countBeautifulNumbers(self, low: int, high: int) -> int:
        def is_beautiful(n):
            return n % 10 == 0 or n % 10 == 1 or n % 10 == 2 or n % 10 == 5 or n % 10 == 8

        count = 0
        for num in range(low, high + 1):
            if is_beautiful(num):
                count += 1
        return count
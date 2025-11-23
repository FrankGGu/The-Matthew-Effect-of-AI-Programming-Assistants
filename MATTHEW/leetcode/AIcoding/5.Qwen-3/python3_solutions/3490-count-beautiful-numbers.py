class Solution:
    def countBeautifulNumbers(self, num: int) -> int:
        from itertools import permutations

        def is_beautiful(n):
            digits = list(str(n))
            for i in range(1, len(digits)):
                if digits[i] == digits[i - 1]:
                    return False
            return True

        def count_valid_numbers(limit):
            count = 0
            for i in range(1, limit + 1):
                if is_beautiful(i):
                    count += 1
            return count

        return count_valid_numbers(num)
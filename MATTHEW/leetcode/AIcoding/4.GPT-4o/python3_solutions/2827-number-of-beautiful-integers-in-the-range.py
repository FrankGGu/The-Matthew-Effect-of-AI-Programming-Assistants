class Solution:
    def beautifulIntegers(self, low: int, high: int) -> int:
        def count_beautiful(n):
            count = 0
            for i in range(1, 10):
                for j in range(0, 10):
                    if i == j:
                        continue
                    number = int(f"{i}{j}{j}{i}")
                    if number <= n:
                        count += 1
            return count

        return count_beautiful(high) - count_beautiful(low - 1)
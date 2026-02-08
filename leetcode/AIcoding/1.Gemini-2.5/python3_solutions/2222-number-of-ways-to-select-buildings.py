class Solution:
    def numberOfWays(self, s: str) -> int:
        count_0 = 0
        count_1 = 0
        count_01 = 0
        count_10 = 0
        total_ways = 0

        for char in s:
            if char == '0':
                total_ways += count_10
                count_10 += count_1
                count_0 += 1
            else: # char == '1'
                total_ways += count_01
                count_01 += count_0
                count_1 += 1

        return total_ways
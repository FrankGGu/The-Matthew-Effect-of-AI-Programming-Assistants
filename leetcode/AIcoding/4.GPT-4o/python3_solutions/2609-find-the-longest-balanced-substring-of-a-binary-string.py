class Solution:
    def findTheLongestBalancedSubstring(self, s: str) -> int:
        max_length = 0
        count_0 = 0
        count_1 = 0

        for char in s:
            if char == '0':
                if count_1 > 0:
                    count_0 = 1
                    count_1 = 0
                else:
                    count_0 += 1
            else:
                count_1 += 1

            if count_0 > 0 and count_1 > 0:
                balanced_length = 2 * min(count_0, count_1)
                max_length = max(max_length, balanced_length)

        return max_length
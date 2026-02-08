class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        count0 = s.count('0')
        count1 = 0
        min_flips = count0

        for char in s:
            if char == '1':
                count1 += 1
            else:
                count0 -= 1

            min_flips = min(min_flips, count1 + count0)

        return min_flips
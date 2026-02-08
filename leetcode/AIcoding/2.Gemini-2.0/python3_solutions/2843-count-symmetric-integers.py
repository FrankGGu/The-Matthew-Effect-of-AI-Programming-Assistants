class Solution:
    def countSymmetricIntegers(self, low: int, high: int) -> int:
        count = 0
        for i in range(low, high + 1):
            s = str(i)
            if len(s) % 2 == 0:
                n = len(s)
                left_sum = 0
                right_sum = 0
                for j in range(n // 2):
                    left_sum += int(s[j])
                    right_sum += int(s[n - 1 - j])
                if left_sum == right_sum:
                    count += 1
        return count
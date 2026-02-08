class Solution:
    def digitCount(self, num: str) -> bool:
        count = [0] * 10
        for digit in num:
            count[int(digit)] += 1
        return all(count[i] == int(num[i]) for i in range(len(num)))
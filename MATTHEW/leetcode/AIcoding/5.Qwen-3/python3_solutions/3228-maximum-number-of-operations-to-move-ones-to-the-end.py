class Solution:
    def maximumNumberOfOperations(self, s: str) -> int:
        count = 0
        ones = 0
        for c in s:
            if c == '1':
                ones += 1
            else:
                if ones > 0:
                    count += 1
        return count
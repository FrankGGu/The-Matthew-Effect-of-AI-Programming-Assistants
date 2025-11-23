from collections import Counter

class Solution:
    def numSquarefulPerms(self, A):
        A.sort()
        count = Counter(A)

        def is_squareful(x, y):
            return (x + y) ** 0.5 % 1 == 0

        def backtrack(prev, remaining):
            if not remaining:
                return 1
            total = 0
            for num in list(count.keys()):
                if count[num] > 0:
                    if prev is None or is_squareful(prev, num):
                        count[num] -= 1
                        total += backtrack(num, remaining - 1)
                        count[num] += 1
            return total

        return backtrack(None, len(A))
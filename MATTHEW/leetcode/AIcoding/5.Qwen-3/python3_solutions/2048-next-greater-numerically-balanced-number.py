class Solution:
    def nextBeautifulNumber(self, n: int) -> int:
        from itertools import permutations

        def is_balanced(x):
            s = str(x)
            count = [0] * 10
            for ch in s:
                count[int(ch)] += 1
            for i in range(1, 10):
                if count[i] == i:
                    continue
                else:
                    return False
            return True

        num = n + 1
        while True:
            if is_balanced(num):
                return num
            num += 1
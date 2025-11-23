class Solution:
    def nextBeautifulNumber(self, n: int) -> int:
        def is_balanced(num):
            s = str(num)
            for d in set(s):
                if s.count(d) != int(d):
                    return False
            return True

        candidate = n + 1
        while True:
            if is_balanced(candidate):
                return candidate
            candidate += 1
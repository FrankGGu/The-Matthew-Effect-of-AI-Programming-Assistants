class Solution:
    def canReorderToPalindrome(self, queries, s):
        from collections import Counter
        res = []
        for q in queries:
            cnt = Counter(s)
            odd = 0
            for v in cnt.values():
                if v % 2 != 0:
                    odd += 1
            if odd <= 1:
                res.append(True)
            else:
                res.append(False)
        return res
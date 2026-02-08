class Solution:
    def wordSubsets(self, words1: List[str], words2: List[str]) -> List[str]:
        def count(word):
            res = [0] * 26
            for c in word:
                res[ord(c) - ord('a')] += 1
            return res

        max_b = [0] * 26
        for b in words2:
            cnt = count(b)
            for i in range(26):
                max_b[i] = max(max_b[i], cnt[i])

        res = []
        for a in words1:
            cnt_a = count(a)
            universal = True
            for i in range(26):
                if cnt_a[i] < max_b[i]:
                    universal = False
                    break
            if universal:
                res.append(a)
        return res
from collections import Counter

class Solution:
    def wordSubsets(self, A: List[str], B: List[str]) -> List[str]:
        b_max = Counter()
        for b in B:
            count = Counter(b)
            for char, num in count.items():
                b_max[char] = max(b_max[char], num)

        res = []
        for a in A:
            count_a = Counter(a)
            valid = True
            for char, num in b_max.items():
                if count_a[char] < num:
                    valid = False
                    break
            if valid:
                res.append(a)

        return res
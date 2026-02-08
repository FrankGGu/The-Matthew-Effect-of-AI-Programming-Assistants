from collections import Counter

class Solution:
    def wordSubsets(self, A: List[str], B: List[str]) -> List[str]:
        b_count = Counter()
        for b in B:
            b_count |= Counter(b)

        result = []
        for a in A:
            a_count = Counter(a)
            if all(a_count[char] >= b_count[char] for char in b_count):
                result.append(a)

        return result
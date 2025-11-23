class Solution:
    def canReorderDoubled(self, A: List[int]) -> bool:
        from collections import Counter

        count = Counter(A)
        for x in sorted(count.keys(), key=abs):
            if count[x] > count[2 * x]:
                return False
            count[2 * x] -= count[x]
        return True
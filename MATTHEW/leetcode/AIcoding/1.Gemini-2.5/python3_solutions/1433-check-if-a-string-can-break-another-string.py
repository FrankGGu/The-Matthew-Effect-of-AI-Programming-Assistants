class Solution:
    def checkIfCanBreak(self, s1: str, s2: str) -> bool:

        def can_break_one_way(a: str, b: str) -> bool:
            n = len(a)
            for i in range(n):
                if a[i] < b[i]:
                    return False
            return True

        sorted_s1 = sorted(s1)
        sorted_s2 = sorted(s2)

        return can_break_one_way(sorted_s1, sorted_s2) or can_break_one_way(sorted_s2, sorted_s1)
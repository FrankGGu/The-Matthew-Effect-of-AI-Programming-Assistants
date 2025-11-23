class Solution:
    def checkIfCanBreak(self, s1: str, s2: str) -> bool:
        s1_sorted = sorted(s1)
        s2_sorted = sorted(s2)

        def can_break(a, b):
            for i in range(len(a)):
                if a[i] < b[i]:
                    return False
            return True

        return can_break(s1_sorted, s2_sorted) or can_break(s2_sorted, s1_sorted)
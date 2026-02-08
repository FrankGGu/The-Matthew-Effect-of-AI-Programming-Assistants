class Solution:
    def checkIfCanBreak(self, s1: str, s2: str) -> bool:
        s1, s2 = sorted(s1), sorted(s2)
        can_break_a = can_break_b = True

        for a, b in zip(s1, s2):
            if a < b:
                can_break_a = False
            if a > b:
                can_break_b = False

        return can_break_a or can_break_b
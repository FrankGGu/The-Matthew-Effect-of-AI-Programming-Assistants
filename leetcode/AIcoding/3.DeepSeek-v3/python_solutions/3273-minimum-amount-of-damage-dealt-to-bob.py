class Solution:
    def minimumDamage(self, A: List[int], B: List[int]) -> int:
        n = len(A)
        A_sorted = sorted(A)
        B_sorted = sorted(B)
        res = 0
        for a, b in zip(A_sorted, reversed(B_sorted)):
            res += a * b
        return res
class Solution:
    def fairCandySwap(self, A: List[int], B: List[int]) -> List[int]:
        sum_a = sum(A)
        sum_b = sum(B)
        diff = (sum_b - sum_a) // 2
        set_b = set(B)
        for a in A:
            if a + diff in set_b:
                return [a, a + diff]
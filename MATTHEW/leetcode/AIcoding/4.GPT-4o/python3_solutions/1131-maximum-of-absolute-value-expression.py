class Solution:
    def maxAbsValExpr(self, arr1: List[int], arr2: List[int]) -> int:
        n = len(arr1)
        max_val = 0

        for sign1 in [1, -1]:
            for sign2 in [1, -1]:
                current_val = max(sign1 * arr1[i] + sign2 * arr2[i] for i in range(n))
                current_val -= min(sign1 * arr1[i] + sign2 * arr2[i] for i in range(n))
                max_val = max(max_val, current_val)

        return max_val
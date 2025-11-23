class Solution:
    def circularPermutation(self, n: int, start: int) -> list[int]:
        gray_code = [i ^ (i >> 1) for i in range(1 << n)]
        start_index = gray_code.index(start)
        return gray_code[start_index:] + gray_code[:start_index]
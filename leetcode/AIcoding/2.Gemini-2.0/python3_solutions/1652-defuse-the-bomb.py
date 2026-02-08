class Solution:
    def decrypt(self, code: List[int], k: int) -> List[int]:
        n = len(code)
        res = [0] * n
        for i in range(n):
            sum_val = 0
            if k > 0:
                for j in range(1, k + 1):
                    sum_val += code[(i + j) % n]
            elif k < 0:
                for j in range(1, -k + 1):
                    sum_val += code[(i - j) % n]
            res[i] = sum_val
        return res
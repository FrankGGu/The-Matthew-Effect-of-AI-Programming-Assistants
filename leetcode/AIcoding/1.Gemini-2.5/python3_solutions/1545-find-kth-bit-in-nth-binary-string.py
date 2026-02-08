class Solution:
    def findKthBit(self, n: int, k: int) -> str:
        if n == 1:
            return "0"

        mid = 1 << (n - 1)

        if k == mid:
            return "1"
        elif k < mid:
            return self.findKthBit(n - 1, k)
        else:
            new_k = (1 << n) - k
            result_from_prev = self.findKthBit(n - 1, new_k)
            return "1" if result_from_prev == "0" else "0"
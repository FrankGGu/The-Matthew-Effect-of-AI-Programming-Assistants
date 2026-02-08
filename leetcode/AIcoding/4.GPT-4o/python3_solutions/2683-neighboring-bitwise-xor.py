class Solution:
    def neighborXOR(self, n: int) -> int:
        return n ^ (n >> 1)
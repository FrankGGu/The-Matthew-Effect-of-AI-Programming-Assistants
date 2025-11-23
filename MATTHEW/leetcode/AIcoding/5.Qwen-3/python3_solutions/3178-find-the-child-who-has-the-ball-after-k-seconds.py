class Solution:
    def ballPassing(self, n: int, k: int) -> int:
        current = 0
        for _ in range(k):
            current = (current + 1) % n
        return current
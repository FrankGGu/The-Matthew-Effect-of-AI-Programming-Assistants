class Solution:
    def minKBitFlips(self, A: List[int], K: int) -> int:
        n = len(A)
        flips = 0
        flip_count = 0
        flip_effect = [0] * n

        for i in range(n):
            if i >= K:
                flip_count ^= flip_effect[i - K]
            if (A[i] ^ flip_count) == 0:
                if i + K > n:
                    return -1
                flips += 1
                flip_count ^= 1
                flip_effect[i] ^= 1
                if i + K < n:
                    flip_effect[i + K] ^= 1

        return flips
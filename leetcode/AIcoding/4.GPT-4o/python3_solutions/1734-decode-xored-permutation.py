class Solution:
    def decode(self, encoded: List[int]) -> List[int]:
        n = len(encoded) + 1
        perm = [0] * n
        total_xor = 0

        for i in range(1, n + 1):
            total_xor ^= i

        odd_xor = 0
        for i in range(1, n - 1, 2):
            odd_xor ^= encoded[i]

        perm[0] = total_xor ^ odd_xor

        for i in range(1, n):
            perm[i] = perm[i - 1] ^ encoded[i - 1]

        return perm
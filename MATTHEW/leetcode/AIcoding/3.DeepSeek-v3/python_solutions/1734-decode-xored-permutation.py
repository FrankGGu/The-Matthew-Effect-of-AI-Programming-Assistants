class Solution:
    def decode(self, encoded: List[int]) -> List[int]:
        n = len(encoded) + 1
        total_xor = 0
        for i in range(1, n + 1):
            total_xor ^= i

        xor_without_first = 0
        for i in range(1, n - 1, 2):
            xor_without_first ^= encoded[i]

        first = total_xor ^ xor_without_first
        perm = [first]

        for num in encoded:
            perm.append(perm[-1] ^ num)

        return perm
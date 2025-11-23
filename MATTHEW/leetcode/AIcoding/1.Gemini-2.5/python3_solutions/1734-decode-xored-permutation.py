class Solution:
    def decode(self, encoded: list[int], n: int) -> list[int]:
        total_xor_all_elements = 0
        for i in range(1, n + 1):
            total_xor_all_elements ^= i

        xor_of_odd_indexed_encoded = 0
        for i in range(1, n - 1, 2):
            xor_of_odd_indexed_encoded ^= encoded[i]

        perm = [0] * n
        perm[0] = total_xor_all_elements ^ xor_of_odd_indexed_encoded

        for i in range(n - 1):
            perm[i+1] = perm[i] ^ encoded[i]

        return perm
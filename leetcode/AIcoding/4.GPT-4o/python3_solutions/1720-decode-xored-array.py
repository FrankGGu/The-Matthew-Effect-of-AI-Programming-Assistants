class Solution:
    def decode(self, encoded: List[int], first: int) -> List[int]:
        n = len(encoded) + 1
        decoded = [0] * n
        decoded[0] = first
        for i in range(1, n):
            decoded[i] = decoded[i - 1] ^ encoded[i - 1]
        return decoded
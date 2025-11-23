class Solution:
    def decode(self, encoded: list[int], first: int) -> list[int]:
        n = len(encoded)
        arr = [0] * (n + 1)
        arr[0] = first

        for i in range(n):
            arr[i+1] = arr[i] ^ encoded[i]

        return arr
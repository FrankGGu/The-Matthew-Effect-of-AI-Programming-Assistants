class Solution:
    def decode(self, encoded: list[int], first: int) -> list[int]:
        arr = [first]
        for num in encoded:
            arr.append(arr[-1] ^ num)
        return arr
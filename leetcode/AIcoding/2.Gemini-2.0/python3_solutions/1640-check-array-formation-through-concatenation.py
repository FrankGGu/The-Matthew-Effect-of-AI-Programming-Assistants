class Solution:
    def canFormArray(self, arr: list[int], pieces: list[list[int]]) -> bool:
        d = {piece[0]: piece for piece in pieces}
        i = 0
        while i < len(arr):
            if arr[i] not in d:
                return False
            piece = d[arr[i]]
            for j in range(len(piece)):
                if i + j >= len(arr) or arr[i + j] != piece[j]:
                    return False
            i += len(piece)
        return True
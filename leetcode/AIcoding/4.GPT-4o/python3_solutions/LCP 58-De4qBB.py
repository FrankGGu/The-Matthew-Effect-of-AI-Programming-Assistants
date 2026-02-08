class Solution:
    def canFormArray(self, arr: List[int], pieces: List[List[int]]) -> bool:
        idx_map = {piece[0]: piece for piece in pieces}
        i = 0

        while i < len(arr):
            if arr[i] not in idx_map:
                return False
            piece = idx_map[arr[i]]
            if arr[i:i + len(piece)] != piece:
                return False
            i += len(piece)

        return True
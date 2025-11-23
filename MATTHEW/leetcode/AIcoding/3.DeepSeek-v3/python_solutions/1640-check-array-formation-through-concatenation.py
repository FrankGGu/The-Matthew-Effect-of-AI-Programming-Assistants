class Solution:
    def canFormArray(self, arr: List[int], pieces: List[List[int]]) -> bool:
        piece_dict = {p[0]: p for p in pieces}
        i = 0
        n = len(arr)
        while i < n:
            if arr[i] not in piece_dict:
                return False
            piece = piece_dict[arr[i]]
            for num in piece:
                if i >= n or arr[i] != num:
                    return False
                i += 1
        return True
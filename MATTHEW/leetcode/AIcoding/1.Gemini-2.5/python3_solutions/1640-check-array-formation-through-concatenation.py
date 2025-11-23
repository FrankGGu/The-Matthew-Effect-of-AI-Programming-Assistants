class Solution:
    def canFormArray(self, arr: list[int], pieces: list[list[int]]) -> bool:
        piece_map = {p[0]: p for p in pieces}

        i = 0
        while i < len(arr):
            current_val = arr[i]
            if current_val not in piece_map:
                return False

            matching_piece = piece_map[current_val]

            if arr[i : i + len(matching_piece)] != matching_piece:
                return False

            i += len(matching_piece)

        return True
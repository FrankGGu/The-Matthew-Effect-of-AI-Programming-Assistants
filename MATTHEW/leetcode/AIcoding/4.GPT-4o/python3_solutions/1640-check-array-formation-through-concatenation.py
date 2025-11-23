def canFormArray(arr: List[int], pieces: List[List[int]]) -> bool:
    piece_map = {p[0]: p for p in pieces}
    i = 0
    while i < len(arr):
        if arr[i] not in piece_map:
            return False
        for num in piece_map[arr[i]]:
            if i >= len(arr) or arr[i] != num:
                return False
            i += 1
    return True
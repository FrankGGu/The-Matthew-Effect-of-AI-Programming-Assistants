def canFormArray(arr, pieces):
    piece_map = {piece[0]: piece for piece in pieces}
    result = []

    for num in arr:
        if num in piece_map:
            result.extend(piece_map[num])
        else:
            return False

    return result == arr
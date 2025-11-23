def furthestDistanceFromOrigin(moves: str) -> int:
    x = 0
    for move in moves:
        if move == 'L':
            x -= 1
        elif move == 'R':
            x += 1
        elif move == 'U':
            x += 1
        elif move == 'D':
            x -= 1
    return abs(x) + moves.count('?')
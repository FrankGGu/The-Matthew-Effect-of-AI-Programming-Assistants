def queensAttacktheKing(queens, king):
    directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    queen_set = set(map(tuple, queens))
    result = []

    for d in directions:
        x, y = king
        while 0 <= x < 8 and 0 <= y < 8:
            if (x, y) in queen_set:
                result.append([x, y])
                break
            x += d[0]
            y += d[1]

    return result
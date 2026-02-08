def stoneGameIX(stones: List[int]) -> bool:
    total = sum(stones)
    mod_count = [0, 0, 0]

    for stone in stones:
        mod_count[stone % 3] += 1

    if mod_count[0] % 2 == 1:
        return mod_count[1] > 0 and mod_count[2] > 0
    else:
        return mod_count[1] > 1 or mod_count[2] > 1
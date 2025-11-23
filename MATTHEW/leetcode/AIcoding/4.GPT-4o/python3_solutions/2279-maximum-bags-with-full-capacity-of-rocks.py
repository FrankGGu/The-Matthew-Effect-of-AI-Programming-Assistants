def maximumBags(capacity: List[int], rocks: List[int], additionalRocks: int) -> int:
    n = len(capacity)
    bags = [capacity[i] - rocks[i] for i in range(n)]
    bags.sort()

    count = 0
    for need in bags:
        if additionalRocks >= need:
            additionalRocks -= need
            count += 1
        else:
            break

    return count
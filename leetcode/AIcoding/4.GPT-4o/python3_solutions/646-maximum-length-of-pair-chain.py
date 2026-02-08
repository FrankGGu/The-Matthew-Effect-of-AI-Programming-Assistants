def findLongestChain(pairs):
    pairs.sort(key=lambda x: x[1])
    count, end = 0, float('-inf')
    for start, finish in pairs:
        if start > end:
            count += 1
            end = finish
    return count
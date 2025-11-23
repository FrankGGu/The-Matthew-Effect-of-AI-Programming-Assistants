from collections import defaultdict

def countPairs(time: list[int], duration: int) -> int:
    count = 0
    freq = defaultdict(int)
    for t in time:
        target = (t - duration - 1) % 1440
        count += freq[target]
        freq[t % 1440] += 1
    return count
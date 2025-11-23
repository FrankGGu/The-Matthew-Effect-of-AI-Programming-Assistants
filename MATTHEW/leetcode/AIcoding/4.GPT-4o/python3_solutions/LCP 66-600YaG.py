def minNumberOfBooths(self, demand: List[str]) -> int:
    count = [0] * 26
    for s in demand:
        for c in set(s):
            count[ord(c) - ord('a')] = max(count[ord(c) - ord('a')], s.count(c))
    return sum(count)
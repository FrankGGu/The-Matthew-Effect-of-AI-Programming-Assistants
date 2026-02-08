from collections import Counter

def minGroupsForValidAssignment(nums):
    counts = Counter(nums)
    min_count = min(counts.values())

    for size in range(min_count, 0, -1):
        possible = True
        groups = 0
        for count in counts.values():
            q, r = divmod(count, size + 1)
            if r > q:
                possible = False
                break
            groups += q
            if r > 0:
                groups += 1
        if possible:
            return groups
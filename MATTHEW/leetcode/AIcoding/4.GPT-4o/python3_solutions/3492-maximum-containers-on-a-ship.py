def maxContainers(A: List[int], k: int) -> int:
    A.sort()
    count = 0
    for a in A:
        if k >= a:
            k -= a
            count += 1
        else:
            break
    return count
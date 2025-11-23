def divideArray(nums):
    from collections import Counter
    count = Counter(nums)
    for value in count.values():
        if value % 2 != 0:
            return False
    return True
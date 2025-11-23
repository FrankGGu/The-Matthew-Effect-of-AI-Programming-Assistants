def isGood(nums):
    from collections import Counter
    count = Counter(nums)
    for k, v in count.items():
        if k > v:
            return False
    return True
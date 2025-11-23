def findPairs(nums, k):
    if k < 0:
        return 0
    num_set = set()
    pairs = set()

    for num in nums:
        if num - k in num_set:
            pairs.add((num - k, num))
        if num + k in num_set:
            pairs.add((num, num + k))
        num_set.add(num)

    return len(pairs)
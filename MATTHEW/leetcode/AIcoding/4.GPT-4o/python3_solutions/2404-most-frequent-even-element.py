def mostFrequentEven(nums):
    count = {}
    for num in nums:
        if num % 2 == 0:
            count[num] = count.get(num, 0) + 1
    if not count:
        return -1
    return max(sorted(count.keys()), key=lambda x: count[x])
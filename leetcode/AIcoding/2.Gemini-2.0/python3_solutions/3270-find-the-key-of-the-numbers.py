def findKey(nums):
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1

    max_count = 0
    key = -1
    for num, c in count.items():
        if c > max_count:
            max_count = c
            key = num
        elif c == max_count and num < key:
            key = num

    return key
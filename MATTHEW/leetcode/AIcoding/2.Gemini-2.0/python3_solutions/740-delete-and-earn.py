def deleteAndEarn(nums):
    points = {}
    for num in nums:
        points[num] = points.get(num, 0) + num

    keys = sorted(points.keys())

    if not keys:
        return 0

    earn1, earn2 = 0, 0
    for i in range(len(keys)):
        current_earn = points[keys[i]]
        if i > 0 and keys[i] == keys[i-1] + 1:
            temp = earn2
            earn2 = max(earn1 + current_earn, earn2)
            earn1 = temp
        else:
            temp = earn2
            earn2 = earn2 + current_earn
            earn1 = temp

    return earn2
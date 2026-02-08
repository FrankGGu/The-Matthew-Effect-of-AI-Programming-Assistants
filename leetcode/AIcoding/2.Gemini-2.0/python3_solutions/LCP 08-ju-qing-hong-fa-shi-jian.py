def getTriggerTime(increase, requirements):
    c, r, m = 0, 1, 2
    n = len(increase)
    k = len(requirements)
    res = [-1] * k
    cur = [0, 0, 0]
    for i in range(n):
        cur[0] += increase[i][0]
        cur[1] += increase[i][1]
        cur[2] += increase[i][2]
        for j in range(k):
            if res[j] == -1 and cur[0] >= requirements[j][0] and cur[1] >= requirements[j][1] and cur[2] >= requirements[j][2]:
                res[j] = i + 1

    for j in range(k):
        if res[j] == -1 and cur[0] >= requirements[j][0] and cur[1] >= requirements[j][1] and cur[2] >= requirements[j][2]:
            res[j] = n

    for j in range(k):
        if res[j] == -1 and requirements[j][0] <= 0 and requirements[j][1] <= 0 and requirements[j][2] <= 0:
            res[j] = 0

    return res
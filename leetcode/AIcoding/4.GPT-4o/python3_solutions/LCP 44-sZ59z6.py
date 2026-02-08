def numTimesAllBlue(flips):
    max_flip = 0
    count = 0
    for i in range(len(flips)):
        max_flip = max(max_flip, flips[i])
        if max_flip == i + 1:
            count += 1
    return count
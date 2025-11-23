def chalkReplacer(chalk, k):
    total_chalk = sum(chalk)
    k %= total_chalk
    for i in range(len(chalk)):
        if k < chalk[i]:
            return i
        k -= chalk[i]
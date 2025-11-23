def stoneGameVI(aliceValues, bobValues):
    values = sorted(zip(aliceValues, bobValues), key=lambda x: x[0] + x[1], reverse=True)
    aliceScore = sum(values[i][0] for i in range(len(values)) if i % 2 == 0)
    bobScore = sum(values[i][1] for i in range(len(values)) if i % 2 == 1)

    if aliceScore > bobScore:
        return 1
    elif aliceScore < bobScore:
        return -1
    else:
        return 0
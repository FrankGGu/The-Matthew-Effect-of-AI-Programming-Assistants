def matchPlayersAndTrainers(players, trainers):
    players.sort()
    trainers.sort()
    p, t = 0, 0
    matches = 0

    while p < len(players) and t < len(trainers):
        if players[p] <= trainers[t]:
            matches += 1
            p += 1
        t += 1

    return matches
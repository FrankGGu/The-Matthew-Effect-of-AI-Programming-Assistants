def findWinners(matches):
    from collections import defaultdict

    loss_count = defaultdict(int)

    for winner, loser in matches:
        loss_count[loser] += 1
        if loser not in loss_count:
            loss_count[loser] = 1

    zero_losses = []
    one_loss = []

    for player in loss_count:
        if loss_count[player] == 0:
            zero_losses.append(player)
        elif loss_count[player] == 1:
            one_loss.append(player)

    zero_losses.sort()
    one_loss.sort()

    return [zero_losses, one_loss]
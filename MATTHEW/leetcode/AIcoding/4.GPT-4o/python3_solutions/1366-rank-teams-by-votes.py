def rankTeams(votes: List[str]) -> str:
    from collections import defaultdict
    count = defaultdict(lambda: [0] * 27)

    for vote in votes:
        for i, team in enumerate(vote):
            count[team][i] += 1

    return ''.join(sorted(count.keys(), key=lambda x: (count[x], x), reverse=True))
def dividePlayers(skill):
    skill.sort()
    total_skill = sum(skill)
    n = len(skill)
    target = total_skill // (n // 2)
    teams = []

    for i in range(n // 2):
        if skill[i] + skill[n - 1 - i] != target:
            return -1
        teams.append(skill[i] * skill[n - 1 - i])

    return sum(teams)
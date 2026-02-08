def pushDominoes(dominoes: str) -> str:
    dominoes = list(dominoes)
    n = len(dominoes)
    forces = [0] * n

    force = 0
    for i in range(n):
        if dominoes[i] == 'R':
            force = n
        elif dominoes[i] == 'L':
            force = 0
        else:
            force = max(force - 1, 0)
        forces[i] += force

    force = 0
    for i in range(n - 1, -1, -1):
        if dominoes[i] == 'L':
            force = n
        elif dominoes[i] == 'R':
            force = 0
        else:
            force = max(force - 1, 0)
        forces[i] -= force

    for i in range(n):
        if forces[i] > 0:
            dominoes[i] = 'R'
        elif forces[i] < 0:
            dominoes[i] = 'L'

    return "".join(dominoes)
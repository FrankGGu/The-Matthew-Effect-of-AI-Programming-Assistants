def minimumEnergy(tasks):
    min_energy = 0
    current_energy = 0

    for task in tasks:
        current_energy += task[0]
        min_energy = max(min_energy, task[1] - current_energy)
        current_energy = max(current_energy - task[1], 0)

    return min_energy + 1
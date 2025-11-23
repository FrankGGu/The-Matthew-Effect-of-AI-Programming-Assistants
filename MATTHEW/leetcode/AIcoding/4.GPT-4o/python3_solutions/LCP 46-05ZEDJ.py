def assignVolunteers(volunteers: List[int], tasks: List[int]) -> int:
    volunteers.sort()
    tasks.sort()
    i = 0
    j = 0
    count = 0

    while i < len(volunteers) and j < len(tasks):
        if volunteers[i] >= tasks[j]:
            count += 1
            j += 1
        i += 1

    return count
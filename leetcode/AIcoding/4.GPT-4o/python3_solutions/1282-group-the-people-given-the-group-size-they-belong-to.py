def groupThePeople(groupSizes):
    from collections import defaultdict

    size_map = defaultdict(list)
    result = []

    for person, size in enumerate(groupSizes):
        size_map[size].append(person)
        if len(size_map[size]) == size:
            result.append(size_map[size])
            size_map[size] = []

    return result
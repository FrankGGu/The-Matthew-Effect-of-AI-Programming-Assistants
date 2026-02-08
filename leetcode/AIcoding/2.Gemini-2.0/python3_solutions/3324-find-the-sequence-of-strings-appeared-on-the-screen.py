def find_sequence(logs):
    """
    Given a list of logs, find the sequence of strings appeared on the screen.
    The logs are in the format of "string1 string2", where string1 is the string that appeared on the screen before string2.
    The returned sequence should be a list of strings.
    """
    graph = {}
    indegree = {}
    for log in logs:
        s1, s2 = log.split()
        if s1 not in graph:
            graph[s1] = []
        if s2 not in graph:
            graph[s2] = []
        if s1 not in indegree:
            indegree[s1] = 0
        if s2 not in indegree:
            indegree[s2] = 0
        graph[s1].append(s2)
        indegree[s2] += 1

    queue = []
    for node in indegree:
        if indegree[node] == 0:
            queue.append(node)

    result = []
    while queue:
        node = queue.pop(0)
        result.append(node)
        for neighbor in graph[node]:
            indegree[neighbor] -= 1
            if indegree[neighbor] == 0:
                queue.append(neighbor)

    if len(result) != len(indegree):
        return []

    return result
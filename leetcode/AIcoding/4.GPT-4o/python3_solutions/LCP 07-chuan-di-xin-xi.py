def numOfMessages(n: int, relations: List[List[int]], time: List[int]) -> int:
    graph = defaultdict(list)
    for u, v in relations:
        graph[u].append(v)

    def dfs(node):
        if node in memo:
            return memo[node]
        max_time = time[node]
        for neighbor in graph[node]:
            max_time = max(max_time, time[node] + dfs(neighbor))
        memo[node] = max_time
        return max_time

    memo = {}
    return max(dfs(i) for i in range(n))
def transportation_plan(adj, start, end, k):
    n = len(adj)
    dp = {}

    def solve(curr, steps):
        if (curr, steps) in dp:
            return dp[(curr, steps)]

        if steps == 0:
            return 1 if curr == end else 0

        count = 0
        for neighbor in adj[curr]:
            count += solve(neighbor, steps - 1)

        dp[(curr, steps)] = count
        return count

    return solve(start, k)
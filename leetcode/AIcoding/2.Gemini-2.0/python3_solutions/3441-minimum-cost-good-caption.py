def solve():
    n = int(input())
    costs = list(map(int, input().split()))
    s = input()

    dp = {}

    def calculate_cost(index, prefix):
        if index == n:
            if len(set(prefix)) == 26:
                return 0
            else:
                return float('inf')

        if (index, tuple(sorted(prefix))) in dp:
            return dp[(index, tuple(sorted(prefix)))]

        cost1 = calculate_cost(index + 1, prefix)
        cost2 = costs[index] + calculate_cost(index + 1, prefix + s[index])

        dp[(index, tuple(sorted(prefix)))] = min(cost1, cost2)
        return dp[(index, tuple(sorted(prefix)))]

    result = calculate_cost(0, "")
    if result == float('inf'):
        print(-1)
    else:
        print(result)

solve()
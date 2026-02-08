def solve():
    def gcd(a, b):
        while b:
            a, b = b, a % b
        return a

    def solve_queries(nums, queries):
        n = len(nums)
        results = []
        for l, r in queries:
            max_gcd = 0
            for i in range(l, r + 1):
                for j in range(i + 1, r + 1):
                    max_gcd = max(max_gcd, gcd(nums[i], nums[j]))
            results.append(max_gcd)
        return results

    nums = [3,1,2,4,5]
    queries = [[0,2],[1,5],[2,4]]
    return solve_queries(nums, queries)
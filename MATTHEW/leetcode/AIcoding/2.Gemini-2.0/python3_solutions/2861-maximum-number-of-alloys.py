def maxNumberOfAlloys(n: int, k: int, budget: int, composition: list[list[int]], stock: list[int], cost: list[int]) -> int:
    def check(num_alloys):
        for i in range(k):
            needed = 0
            for j in range(n):
                needed += max(0, composition[i][j] * num_alloys - stock[j]) * cost[j]
            if needed <= budget:
                return True
        return False

    left, right = 0, 2 * 10**8
    ans = 0
    while left <= right:
        mid = (left + right) // 2
        if check(mid):
            ans = mid
            left = mid + 1
        else:
            right = mid - 1
    return ans
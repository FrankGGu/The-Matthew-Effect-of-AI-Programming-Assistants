class Solution:
    def makeArrayIncreasing(self, arr1: List[int], arr2: List[int]) -> int:
        arr2.sort()
        dp = {float('-inf'): 0}

        for x in arr1:
            new_dp = {}
            for y in dp:
                if x > y:
                    new_dp[x] = min(new_dp.get(x, float('inf')), dp[y])
                idx = bisect.bisect_right(arr2, y)
                if idx < len(arr2):
                    new_dp[arr2[idx]] = min(new_dp.get(arr2[idx], float('inf')), dp[y] + 1)
            dp = new_dp

        return min(dp.values(), default=float('inf')) if dp else -1
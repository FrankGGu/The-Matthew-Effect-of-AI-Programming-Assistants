from bisect import bisect_right

class Solution:
    def makeArrayIncreasing(self, arr1: list[int], arr2: list[int]) -> int:
        arr2.sort()
        dp = {-1: 0}
        for num in arr1:
            new_dp = {}
            for prev in dp:
                if num > prev:
                    new_dp[num] = min(new_dp.get(num, float('inf')), dp[prev])
                idx = bisect_right(arr2, prev)
                if idx < len(arr2):
                    new_num = arr2[idx]
                    new_dp[new_num] = min(new_dp.get(new_num, float('inf')), dp[prev] + 1)
            dp = new_dp
        if not dp:
            return -1
        return min(dp.values())
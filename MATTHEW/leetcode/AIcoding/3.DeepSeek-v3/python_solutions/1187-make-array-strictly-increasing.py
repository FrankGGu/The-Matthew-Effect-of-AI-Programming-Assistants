import bisect

class Solution:
    def makeArrayIncreasing(self, arr1: List[int], arr2: List[int]) -> int:
        arr2 = sorted(set(arr2))
        n = len(arr1)
        m = len(arr2)

        dp = {}
        dp[-1] = 0

        for num in arr1:
            new_dp = {}
            for key in dp:
                if num > key:
                    if key in new_dp:
                        new_dp[key] = min(new_dp[key], dp[key])
                    else:
                        new_dp[num] = dp[key]
                idx = bisect.bisect_right(arr2, key)
                if idx < m:
                    if arr2[idx] in new_dp:
                        new_dp[arr2[idx]] = min(new_dp[arr2[idx]], dp[key] + 1)
                    else:
                        new_dp[arr2[idx]] = dp[key] + 1
            dp = new_dp
            if not dp:
                return -1

        return min(dp.values()) if dp else -1
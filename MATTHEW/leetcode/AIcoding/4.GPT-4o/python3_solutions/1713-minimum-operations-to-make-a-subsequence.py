class Solution:
    def minOperations(self, target: List[int], arr: List[int]) -> int:
        target_set = set(target)
        arr_filtered = [num for num in arr if num in target_set]

        dp = []
        for num in arr_filtered:
            pos = bisect.bisect_left(dp, num)
            if pos == len(dp):
                dp.append(num)
            else:
                dp[pos] = num

        return len(target) - len(dp)
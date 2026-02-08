def lengthOfLongestSubsequence(nums: list[int], target: int) -> int:
    n = len(nums)
    dp = {}

    def solve(index, current_sum):
        if index == n:
            return 0 if current_sum == target else float('-inf')

        if (index, current_sum) in dp:
            return dp[(index, current_sum)]

        take = 1 + solve(index + 1, current_sum + nums[index])
        skip = solve(index + 1, current_sum)

        dp[(index, current_sum)] = max(take, skip)
        return dp[(index, current_sum)]

    result = solve(0, 0)
    return result if result > 0 else -1
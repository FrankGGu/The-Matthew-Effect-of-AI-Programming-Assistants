def max_valid_subsequence(nums: list[int], k: int) -> int:
    n = len(nums)
    dp = {}

    def solve(index: int, last_num: int) -> int:
        if index == n:
            return 0

        if (index, last_num) in dp:
            return dp[(index, last_num)]

        exclude = solve(index + 1, last_num)
        include = 0
        if last_num == -1 or nums[index] % last_num == 0 or last_num % nums[index] == 0:
            include = 1 + solve(index + 1, nums[index])

        dp[(index, last_num)] = max(include, exclude)
        return dp[(index, last_num)]

    return solve(0, -1)
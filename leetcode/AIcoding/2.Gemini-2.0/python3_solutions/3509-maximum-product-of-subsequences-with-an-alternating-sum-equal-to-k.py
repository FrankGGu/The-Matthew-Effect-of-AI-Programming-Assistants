def maxProduct(nums, k):
    n = len(nums)
    dp = {}

    def solve(idx, sum_so_far, sign):
        if idx == n:
            if sum_so_far == k:
                return 1
            else:
                return 0

        if (idx, sum_so_far, sign) in dp:
            return dp[(idx, sum_so_far, sign)]

        ans = solve(idx + 1, sum_so_far, sign)

        val = nums[idx]
        if sign == 1:
            new_sum = sum_so_far + val
        else:
            new_sum = sum_so_far - val

        prod = nums[idx] * solve(idx + 1, new_sum, -sign)

        if prod > 0 and ans > 0:
            ans = max(ans, prod)
        elif prod > 0:
            ans = prod

        dp[(idx, sum_so_far, sign)] = ans

        return ans

    result = solve(0, 0, 1)

    if result == 0 and k == 0 and any(num == 0 for num in nums):
        return 0
    elif result == 0 and k != 0:
        return 0
    else:
        return result
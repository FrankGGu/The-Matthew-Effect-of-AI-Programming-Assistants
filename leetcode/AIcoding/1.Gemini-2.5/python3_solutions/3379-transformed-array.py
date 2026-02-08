class Solution:
    def sortTransformedArray(self, nums: list[int], a: int, b: int, c: int) -> list[int]:
        def calculate_f(x):
            return a * x * x + b * x + c

        n = len(nums)
        res = [0] * n

        if a == 0:
            for i in range(n):
                res[i] = calculate_f(nums[i])
            if b < 0:
                res.reverse()
            return res

        left = 0
        right = n - 1

        if a > 0:
            idx = n - 1
            while left <= right:
                val_left = calculate_f(nums[left])
                val_right = calculate_f(nums[right])
                if val_left > val_right:
                    res[idx] = val_left
                    left += 1
                else:
                    res[idx] = val_right
                    right -= 1
                idx -= 1
            return res
        else: # a < 0
            idx = 0
            while left <= right:
                val_left = calculate_f(nums[left])
                val_right = calculate_f(nums[right])
                if val_left < val_right:
                    res[idx] = val_left
                    left += 1
                else:
                    res[idx] = val_right
                    right -= 1
                idx += 1
            return res
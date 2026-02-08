class Solution:
    def productExceptSelf(self, nums: list[int]) -> list[int]:
        n = len(nums)
        answer = [0] * n

        answer[0] = 1
        for i in range(1, n):
            answer[i] = answer[i - 1] * nums[i - 1]

        right_product = 1
        for i in range(n - 1, -1, -1):
            answer[i] = answer[i] * right_product
            right_product *= nums[i]

        return answer
class Solution:
    def splitArray(self, nums: List[int]) -> bool:
        n = len(nums)
        if n < 7:
            return False

        total_sum = sum(nums)

        for i in range(1, n - 5):
            sum1 = sum(nums[:i])

            for j in range(i + 2, n - 3):
                sum2 = sum(nums[i+1:j])

                for k in range(j + 2, n - 1):
                    sum3 = sum(nums[j+1:k])
                    sum4 = sum(nums[k+1:])

                    if sum1 == sum2 == sum3 == sum4:
                        return True

        return False
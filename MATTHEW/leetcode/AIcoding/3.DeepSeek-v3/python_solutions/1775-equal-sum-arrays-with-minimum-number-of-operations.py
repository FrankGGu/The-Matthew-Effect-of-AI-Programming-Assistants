class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int]) -> int:
        sum1, sum2 = sum(nums1), sum(nums2)
        if sum1 == sum2:
            return 0
        if sum1 > sum2:
            return self.helper(nums1, nums2, sum1 - sum2)
        else:
            return self.helper(nums2, nums1, sum2 - sum1)

    def helper(self, larger, smaller, diff):
        count = [0] * 6
        for num in larger:
            count[num - 1] += 1
        for num in smaller:
            count[6 - num] += 1

        res = 0
        for i in range(5, 0, -1):
            if diff <= 0:
                break
            max_reduce = i * count[i]
            if diff >= max_reduce:
                res += count[i]
                diff -= max_reduce
            else:
                res += (diff + i - 1) // i
                diff = 0
        return res if diff <= 0 else -1
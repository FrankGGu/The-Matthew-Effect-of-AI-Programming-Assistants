class Solution:
    def canSortArray(self, nums: List[int]) -> bool:
        n = len(nums)
        i = 0
        while i < n - 1:
            j = i
            curr_power = 0
            while j < n and bin(nums[i]).count('1') == bin(nums[j]).count('1'):
                curr_power = bin(nums[i]).count('1')
                j += 1

            sub_array = nums[i:j]
            sub_array.sort()

            nums[i:j] = sub_array

            i = j

        for i in range(n - 1):
            if nums[i] > nums[i+1]:
                return False

        return True
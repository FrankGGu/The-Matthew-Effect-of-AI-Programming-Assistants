class Solution:
    def findTheNumberOfCopyArrays(self, nums: list[int], arr: list[int], k: int) -> int:
        arr_set = set(arr)

        total_valid_arrays = 1

        for i in range(len(nums)):
            val1 = nums[i] - k
            val2 = nums[i] + k

            current_num_choices = 0

            if k == 0:
                # If k is 0, nums[i] - k and nums[i] + k are both nums[i].
                # So b[i] must be nums[i].
                if nums[i] in arr_set:
                    current_num_choices = 1
                else:
                    current_num_choices = 0
            else:
                # If k is not 0, nums[i] - k and nums[i] + k are distinct.
                if val1 in arr_set:
                    current_num_choices += 1
                if val2 in arr_set:
                    current_num_choices += 1

            if current_num_choices == 0:
                # If there are no valid choices for b[i], then no valid copy array can be formed.
                return 0

            total_valid_arrays *= current_num_choices

        return total_valid_arrays
def longestAlternatingSubarray(nums):
    max_len = 0
    for start in range(len(nums)):
        for end in range(start, len(nums)):
            sub_array = nums[start:end+1]
            if len(sub_array) > max_len:
                is_alternating = True
                if len(sub_array) > 1:
                    for i in range(1, len(sub_array)):
                        if sub_array[i] % 2 == sub_array[i-1] % 2:
                            is_alternating = False
                            break
                if is_alternating:
                    max_len = len(sub_array)
    return max_len
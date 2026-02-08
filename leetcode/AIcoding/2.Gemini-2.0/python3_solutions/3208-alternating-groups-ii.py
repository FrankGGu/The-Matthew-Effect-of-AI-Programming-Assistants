def alternatingSubarray(nums):
    max_len = -1
    for i in range(len(nums) - 1):
        length = 1
        diff = nums[i+1] - nums[i]
        if abs(diff) == 1:
            length = 2
            expected_diff = -diff
            for j in range(i + 2, len(nums)):
                new_diff = nums[j] - nums[j-1]
                if new_diff == expected_diff:
                    length += 1
                    expected_diff = -expected_diff
                else:
                    break
            max_len = max(max_len, length)
    return max_len
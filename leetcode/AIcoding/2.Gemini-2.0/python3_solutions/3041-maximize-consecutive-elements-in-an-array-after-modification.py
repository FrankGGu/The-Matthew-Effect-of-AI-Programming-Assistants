def maxConsecutive(nums: list[int]) -> int:
    nums.sort()
    n = len(nums)
    max_len = 1
    for i in range(n):
        curr_len = 1
        curr_val = nums[i]
        for j in range(i + 1, n):
            if nums[j] == curr_val + 1:
                curr_len += 1
                curr_val += 1
            elif nums[j] > curr_val + 1:
                diff = nums[j] - (curr_val + 1)
                if diff <= 1:
                    curr_len += 1
                    curr_val = nums[j]
                else:
                    break
        max_len = max(max_len, curr_len)
    return max_len
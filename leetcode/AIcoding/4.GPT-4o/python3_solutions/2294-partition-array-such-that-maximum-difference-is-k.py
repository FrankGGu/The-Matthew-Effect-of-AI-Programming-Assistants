def partitionArray(self, nums: List[int], k: int) -> int:
    nums.sort()
    count = 1
    min_value = nums[0]

    for num in nums:
        if num - min_value > k:
            count += 1
            min_value = num

    return count
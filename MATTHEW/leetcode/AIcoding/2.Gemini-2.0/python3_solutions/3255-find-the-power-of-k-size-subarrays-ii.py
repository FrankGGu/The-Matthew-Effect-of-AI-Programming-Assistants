def findPowerOfKSizeSubarrays(nums: list[int], k: int) -> int:
    n = len(nums)
    count = 0
    for i in range(n - k + 1):
        subarray = nums[i:i + k]
        power = 1
        for num in subarray:
            power *= num
        count += power
    return count
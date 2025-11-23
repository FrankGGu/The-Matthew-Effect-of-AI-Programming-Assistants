def findMinimumArrayEnd(nums: list[int], k: int) -> int:
    n = len(nums)
    if n == 0:
        return -1

    if k >= n:
        return nums[-1]

    return nums[k]
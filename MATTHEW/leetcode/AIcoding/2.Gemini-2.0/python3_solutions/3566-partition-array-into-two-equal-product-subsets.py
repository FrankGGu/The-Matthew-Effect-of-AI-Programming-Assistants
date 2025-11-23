def canPartition(nums):
    product = 1
    for num in nums:
        product *= num

    if product == 0:
        return nums.count(0) > 1

    if product < 0:
        return True

    n = len(nums)
    target = int(product**0.5)

    if target * target != product:
        return False

    def backtrack(index, current_product):
        if current_product == target:
            return True
        if index == n or current_product > target:
            return False

        if backtrack(index + 1, current_product * nums[index]):
            return True
        if backtrack(index + 1, current_product):
            return True

        return False

    return backtrack(0, 1)
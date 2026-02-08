def subarrayGCD(nums, k):
    count = 0
    for i in range(len(nums)):
        gcd = 0
        for j in range(i, len(nums)):
            if gcd == 0:
                gcd = nums[j]
            else:
                gcd = gcd_func(gcd, nums[j])
            if gcd == k:
                count += 1
            elif gcd < k:
                break
    return count

def gcd_func(a, b):
    while b:
        a, b = b, a % b
    return a
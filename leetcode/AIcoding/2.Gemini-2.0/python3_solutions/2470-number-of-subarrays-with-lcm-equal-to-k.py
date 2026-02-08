def subarrayLCM(nums, k):
    count = 0
    for i in range(len(nums)):
        lcm = 1
        for j in range(i, len(nums)):
            lcm = lcm * nums[j] // gcd(lcm, nums[j])
            if lcm == k:
                count += 1
            elif lcm > k:
                break
    return count

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a
import math

def minOperations(nums: list[int], numsDivide: list[int]) -> int:
    g = numsDivide[0]
    for i in range(1, len(numsDivide)):
        g = math.gcd(g, numsDivide[i])

    nums.sort()
    for i in range(len(nums)):
        if g % nums[i] == 0:
            return i

    return -1
from collections import Counter
import math

def numSquarefulPerms(nums):
    def is_square(n):
        if n < 0:
            return False
        root = int(math.sqrt(n))
        return root * root == n

    def permute(arr, used, count, result):
        if len(arr) == len(nums):
            result.append(arr.copy())
            return

        for num in counts:
            if counts[num] > used[num]:
                if len(arr) > 0 and not is_square(arr[-1] + num):
                    continue
                arr.append(num)
                used[num] += 1
                permute(arr, used, count, result)
                used[num] -= 1
                arr.pop()

    counts = Counter(nums)
    used = {num: 0 for num in counts}
    result = []
    permute([], used, counts, result)
    return len(result)
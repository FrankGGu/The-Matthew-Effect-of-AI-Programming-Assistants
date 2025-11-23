from collections import Counter

class Solution:
    def recoverArray(self, nums: list[int]) -> list[int]:
        n = len(nums)
        nums.sort()
        for i in range(1, n):
            if (nums[i] - nums[0]) % 2 == 0:
                k = (nums[i] - nums[0]) // 2
                if k == 0:
                    continue
                count = Counter(nums)
                res = []
                valid = True
                for num in nums:
                    if count[num] == 0:
                        continue
                    count[num] -= 1
                    if count[num + 2 * k] == 0:
                        valid = False
                        break
                    count[num + 2 * k] -= 1
                    res.append(num + k)
                if valid:
                    return res
        return []
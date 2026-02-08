class Solution:
    def recoverArray(self, nums: List[int]) -> List[int]:
        nums.sort()
        n = len(nums)
        possible_ks = set()

        for i in range(1, n):
            diff = nums[i] - nums[0]
            if diff > 0 and diff % 2 == 0:
                possible_ks.add(diff // 2)

        for k in possible_ks:
            res = []
            used = [False] * n
            left = 0
            valid = True
            for right in range(n):
                if used[right]:
                    continue
                if left >= n:
                    break
                if nums[right] == nums[left] + 2 * k:
                    res.append(nums[left] + k)
                    used[right] = True
                    left += 1
                    while left < n and used[left]:
                        left += 1
                elif nums[right] < nums[left] + 2 * k:
                    continue
                else:
                    valid = False
                    break
            if valid and len(res) == n // 2:
                return res

        return []
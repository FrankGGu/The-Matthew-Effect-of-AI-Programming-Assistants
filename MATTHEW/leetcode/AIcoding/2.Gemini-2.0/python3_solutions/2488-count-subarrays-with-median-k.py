class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        pos = -1
        for i in range(n):
            if nums[i] == k:
                pos = i
                break

        ans = 0
        counts = {0: 1}
        balance = 0

        for i in range(pos - 1, -1, -1):
            if nums[i] > k:
                balance += 1
            else:
                balance -= 1

            if balance in counts:
                counts[balance] += 1
            else:
                counts[balance] = 1

        balance = 0
        for i in range(pos, n):
            if nums[i] > k:
                balance += 1
            elif nums[i] < k:
                balance -= 1

            ans += counts.get(-balance, 0) + counts.get(1 - balance, 0)

        return ans
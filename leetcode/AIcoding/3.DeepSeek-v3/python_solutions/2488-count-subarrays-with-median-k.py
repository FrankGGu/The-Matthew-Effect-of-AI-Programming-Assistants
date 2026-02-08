class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        pos = nums.index(k)
        count = defaultdict(int)
        count[0] = 1
        res = 0
        balance = 0

        for i in range(pos + 1, len(nums)):
            balance += 1 if nums[i] > k else -1
            count[balance] += 1

        res += count[0] + count[1]
        balance = 0

        for i in range(pos - 1, -1, -1):
            balance += 1 if nums[i] < k else -1
            res += count[balance] + count[balance + 1]

        return res
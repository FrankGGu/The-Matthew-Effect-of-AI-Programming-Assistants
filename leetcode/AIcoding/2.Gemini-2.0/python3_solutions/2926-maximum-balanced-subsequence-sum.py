class Solution:
    def maxBalancedSubsequenceSum(self, nums: List[int]) -> int:
        n = len(nums)
        vals = sorted(set(nums[i] - i for i in range(n)))
        val_map = {v: i for i, v in enumerate(vals)}
        bit = [float('-inf')] * (len(vals) + 1)

        def update(idx, val):
            idx += 1
            while idx <= len(vals):
                bit[idx] = max(bit[idx], val)
                idx += idx & -idx

        def query(idx):
            idx += 1
            res = float('-inf')
            while idx > 0:
                res = max(res, bit[idx])
                idx -= idx & -idx
            return res

        ans = float('-inf')
        for i in range(n):
            idx = val_map[nums[i] - i]
            prev = query(idx)
            curr = max(nums[i], prev + nums[i])
            ans = max(ans, curr)
            update(idx, curr)

        return ans
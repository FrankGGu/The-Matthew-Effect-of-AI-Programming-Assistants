class Solution:
    def minCostToEqualizeArray(self, nums: List[int], cost1: int, cost2: int) -> int:
        MOD = 10**9 + 7
        max_num = max(nums)
        min_num = min(nums)
        total = 0
        operations = []

        for num in nums:
            operations.append(max_num - num)

        operations.sort()
        total_ops = sum(operations)

        if cost1 * 2 <= cost2:
            return (total_ops * cost1) % MOD

        res = float('inf')
        max_target = max_num + total_ops

        for target in range(max_num, max_target + 1):
            current_ops = []
            for num in nums:
                current_ops.append(target - num)
            current_ops.sort()
            total_current = sum(current_ops)
            max_op = current_ops[-1]
            sum_rest = total_current - max_op

            if sum_rest >= max_op:
                cost = (total_current // 2) * cost2
                if total_current % 2 != 0:
                    cost += cost1
            else:
                cost = sum_rest * cost2 + (max_op - sum_rest) * cost1
            res = min(res, cost)

        return res % MOD
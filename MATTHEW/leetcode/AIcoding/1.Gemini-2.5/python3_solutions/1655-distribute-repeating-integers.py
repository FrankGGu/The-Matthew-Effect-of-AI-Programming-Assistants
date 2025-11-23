import collections

class Solution:
    def canDistribute(self, nums: list[int], quantity: list[int]) -> bool:
        counts = list(collections.Counter(nums).values())

        quantity.sort(reverse=True)

        m = len(quantity)
        n_distinct_items = len(counts)

        dp = {}

        def solve(cust_idx: int, current_counts: tuple[int, ...]) -> bool:
            if cust_idx == m:
                return True

            if (cust_idx, current_counts) in dp:
                return dp[(cust_idx, current_counts)]

            for i in range(n_distinct_items):
                if current_counts[i] >= quantity[cust_idx]:
                    new_counts_list = list(current_counts)
                    new_counts_list[i] -= quantity[cust_idx]

                    if solve(cust_idx + 1, tuple(new_counts_list)):
                        dp[(cust_idx, current_counts)] = True
                        return True

            dp[(cust_idx, current_counts)] = False
            return False

        return solve(0, tuple(counts))
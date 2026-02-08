from collections import Counter

class Solution:
    def canDistribute(self, nums, quantity):
        count = list(Counter(nums).values())
        quantity.sort(reverse=True)
        n = len(count)
        m = len(quantity)

        def backtrack(idx):
            if idx == m:
                return True

            for i in range(n):
                if count[i] >= quantity[idx]:
                    count[i] -= quantity[idx]
                    if backtrack(idx + 1):
                        return True
                    count[i] += quantity[idx]
            return False

        return backtrack(0)
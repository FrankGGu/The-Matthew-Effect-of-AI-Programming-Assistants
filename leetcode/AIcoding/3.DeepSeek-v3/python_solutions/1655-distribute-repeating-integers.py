class Solution:
    def canDistribute(self, nums: List[int], quantity: List[int]) -> bool:
        from collections import Counter
        freq = list(Counter(nums).values())
        quantity.sort(reverse=True)
        n = len(freq)
        m = len(quantity)

        def backtrack(pos):
            if pos == m:
                return True
            for i in range(n):
                if freq[i] >= quantity[pos]:
                    freq[i] -= quantity[pos]
                    if backtrack(pos + 1):
                        return True
                    freq[i] += quantity[pos]
            return False

        return backtrack(0)
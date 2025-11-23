class Solution:
    def largestCombination(self, candidates: List[int]) -> int:
        ans = 0
        for i in range(32):
            count = 0
            for num in candidates:
                if (num >> i) & 1:
                    count += 1
            ans = max(ans, count)
        return ans
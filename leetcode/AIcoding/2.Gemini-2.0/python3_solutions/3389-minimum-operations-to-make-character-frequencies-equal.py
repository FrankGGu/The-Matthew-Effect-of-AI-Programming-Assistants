from collections import Counter

class Solution:
    def minOperations(self, s: str) -> int:
        counts = list(Counter(s).values())
        counts.sort(reverse=True)
        n = len(counts)
        ans = float('inf')
        for target in range(1, max(counts) + 1):
            ops = 0
            for count in counts:
                if count > target:
                    ops += count - target
            ans = min(ans, ops)

        ops = sum(counts) - n
        ans = min(ans,ops)

        freq = [0] * (max(counts) + 1)
        for count in counts:
            freq[count] += 1

        for target in range(1,max(counts)+1):
            ops = 0

            for i in range(target+1,len(freq)):
                ops += freq[i]*(i-target)

            ans = min(ans,ops)

        return ans
class Solution:
    def storeWater(self, bucket: List[int], vat: List[int]) -> int:
        n = len(bucket)
        max_vat = max(vat)
        if max_vat == 0:
            return 0

        ans = float('inf')
        for k in range(1, 10001):
            t = 0
            for i in range(n):
                t += max(0, (vat[i] + k - 1) // k - bucket[i])
            ans = min(ans, t + k)

        return ans
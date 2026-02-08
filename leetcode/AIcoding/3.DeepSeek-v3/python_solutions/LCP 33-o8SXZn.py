class Solution:
    def storeWater(self, bucket: List[int], vat: List[int]) -> int:
        max_k = max(vat)
        if max_k == 0:
            return 0
        res = float('inf')
        for k in range(1, max_k + 1):
            t = 0
            for i in range(len(bucket)):
                t += max(0, (vat[i] + k - 1) // k - bucket[i])
            res = min(res, t + k)
        return res
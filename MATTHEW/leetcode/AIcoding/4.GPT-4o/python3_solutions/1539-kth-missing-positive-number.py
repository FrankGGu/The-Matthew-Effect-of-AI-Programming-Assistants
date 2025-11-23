class Solution:
    def findKthPositive(self, arr: List[int], k: int) -> int:
        missing = []
        for i in range(1, max(arr) + k + 1):
            if i not in arr:
                missing.append(i)
                if len(missing) == k:
                    return i
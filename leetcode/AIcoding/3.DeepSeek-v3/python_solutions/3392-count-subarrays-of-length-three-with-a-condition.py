class Solution:
    def countGoodSubarrays(self, arr: List[int], k: int) -> int:
        count = 0
        n = len(arr)
        for i in range(n - 2):
            a, b, c = arr[i], arr[i+1], arr[i+2]
            if (a == b and b == c) or (a != b and b != c and a != c):
                count += 1
        return count
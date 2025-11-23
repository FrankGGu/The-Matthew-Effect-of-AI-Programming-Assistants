class Solution:
    def detectPattern(self, arr: List[int], m: int, k: int) -> bool:
        n = len(arr)
        for i in range(n - m * k + 1):
            pattern = arr[i:i + m]
            count = 1
            j = i + m
            while j <= n - m:
                if arr[j:j + m] == pattern:
                    count += 1
                    j += m
                else:
                    break
            if count >= k:
                return True
        return False
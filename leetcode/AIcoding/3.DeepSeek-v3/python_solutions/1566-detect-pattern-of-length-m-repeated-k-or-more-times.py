class Solution:
    def containsPattern(self, arr: List[int], m: int, k: int) -> bool:
        n = len(arr)
        for i in range(n - m * k + 1):
            pattern = arr[i:i + m]
            valid = True
            for j in range(1, k):
                start = i + j * m
                end = start + m
                if end > n or arr[start:end] != pattern:
                    valid = False
                    break
            if valid:
                return True
        return False
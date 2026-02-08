class Solution:
    def containsPattern(self, arr: list[int], m: int, k: int) -> bool:
        n = len(arr)
        for i in range(n - m * k + 1):
            pattern = arr[i : i + m]
            repetitions = 1
            for j in range(i + m, n - m + 1, m):
                if arr[j : j + m] == pattern:
                    repetitions += 1
                else:
                    break

            if repetitions >= k:
                return True

        return False
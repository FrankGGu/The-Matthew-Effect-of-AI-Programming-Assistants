class Solution:
    def findStableArrays(self, n: int) -> List[List[int]]:
        def is_stable(arr):
            for i in range(n):
                if arr[i] == 1 and i > 0 and arr[i - 1] == 1:
                    return False
                if arr[i] == 0 and i < n - 1 and arr[i + 1] == 0:
                    return False
            return True

        def backtrack(index, current):
            if index == n:
                if is_stable(current):
                    result.append(current[:])
                return
            current[index] = 0
            backtrack(index + 1, current)
            current[index] = 1
            backtrack(index + 1, current)

        result = []
        backtrack(0, [0] * n)
        return result
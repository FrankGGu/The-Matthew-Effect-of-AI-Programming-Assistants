class Solution:
    def minimumAbsoluteDifference(self, arr: List[int]) -> List[List[int]]:
        arr.sort()

        min_diff = float('inf')

        for i in range(1, len(arr)):
            current_diff = arr[i] - arr[i-1]
            if current_diff < min_diff:
                min_diff = current_diff

        result = []
        for i in range(1, len(arr)):
            if arr[i] - arr[i-1] == min_diff:
                result.append([arr[i-1], arr[i]])

        return result
class Solution:
    def maximumSum(self, arr: List[int], k: int) -> int:
        n = len(arr)
        if n == 0 or k == 0:
            return 0

        max_sum = float('-inf')
        current_sum = 0
        window = deque()

        for i in range(n):
            current_sum += arr[i]
            window.append(arr[i])

            if len(window) > k:
                current_sum -= window.popleft()

            if len(window) == k:
                max_sum = max(max_sum, current_sum)

        return max_sum
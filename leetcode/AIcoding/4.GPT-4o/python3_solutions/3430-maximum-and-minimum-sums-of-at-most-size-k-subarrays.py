from collections import deque

class Solution:
    def maximumSum(self, arr: List[int], k: int) -> int:
        n = len(arr)
        if n == 0 or k == 0:
            return 0

        max_sum = float('-inf')
        min_sum = float('inf')

        max_deque = deque()
        min_deque = deque()

        current_sum = 0

        for i in range(n):
            current_sum += arr[i]

            while max_deque and arr[max_deque[-1]] <= arr[i]:
                max_deque.pop()
            max_deque.append(i)

            while min_deque and arr[min_deque[-1]] >= arr[i]:
                min_deque.pop()
            min_deque.append(i)

            if i >= k - 1:
                if max_deque[0] == i - k:
                    max_deque.popleft()
                if min_deque[0] == i - k:
                    min_deque.popleft()

                max_sum = max(max_sum, current_sum - (arr[min_deque[0]] if min_deque else 0))
                min_sum = min(min_sum, current_sum - (arr[max_deque[0]] if max_deque else 0))

                current_sum -= arr[i - k + 1]

        return max_sum, min_sum
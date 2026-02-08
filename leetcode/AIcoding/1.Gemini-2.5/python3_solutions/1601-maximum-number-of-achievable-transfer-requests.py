class Solution:
    def maximumRequests(self, n: int, requests: list[list[int]]) -> int:
        m = len(requests)
        max_achievable_requests = 0

        for i in range(1 << m):
            current_requests_count = 0
            balance = [0] * n

            for j in range(m):
                if (i >> j) & 1:
                    current_requests_count += 1
                    from_building, to_building = requests[j]
                    balance[from_building] -= 1
                    balance[to_building] += 1

            is_balanced = True
            for k in range(n):
                if balance[k] != 0:
                    is_balanced = False
                    break

            if is_balanced:
                max_achievable_requests = max(max_achievable_requests, current_requests_count)

        return max_achievable_requests
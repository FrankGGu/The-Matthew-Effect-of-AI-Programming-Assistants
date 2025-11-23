class Solution:
    def maximumRequests(self, n: int, requests: List[List[int]]) -> int:
        def is_valid(state):
            balance = [0] * n
            for u, v in state:
                balance[u] -= 1
                balance[v] += 1
            return all(b == 0 for b in balance)

        max_requests = 0
        total_requests = len(requests)

        for i in range(1 << total_requests):
            state = []
            for j in range(total_requests):
                if i & (1 << j):
                    state.append(requests[j])
            if is_valid(state):
                max_requests = max(max_requests, len(state))

        return max_requests
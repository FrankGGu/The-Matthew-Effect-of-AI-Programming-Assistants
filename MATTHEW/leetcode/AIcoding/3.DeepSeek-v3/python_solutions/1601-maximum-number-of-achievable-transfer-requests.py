class Solution:
    def maximumRequests(self, n: int, requests: List[List[int]]) -> int:
        max_requests = 0
        m = len(requests)

        for mask in range(1 << m):
            count = bin(mask).count('1')
            if count <= max_requests:
                continue
            balance = [0] * n
            for i in range(m):
                if mask & (1 << i):
                    from_, to_ = requests[i]
                    balance[from_] -= 1
                    balance[to_] += 1
            if all(b == 0 for b in balance):
                max_requests = count

        return max_requests
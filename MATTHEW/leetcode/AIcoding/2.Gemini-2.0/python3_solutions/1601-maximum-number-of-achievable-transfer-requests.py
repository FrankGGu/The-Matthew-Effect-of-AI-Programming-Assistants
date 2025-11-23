class Solution:
    def maximumRequests(self, n: int, requests: List[List[int]]) -> int:
        ans = 0
        for mask in range(1 << len(requests)):
            cnt = 0
            indegree = [0] * n
            outdegree = [0] * n
            for i in range(len(requests)):
                if (mask >> i) & 1:
                    cnt += 1
                    outdegree[requests[i][0]] += 1
                    indegree[requests[i][1]] += 1

            valid = True
            for i in range(n):
                if indegree[i] != outdegree[i]:
                    valid = False
                    break

            if valid:
                ans = max(ans, cnt)

        return ans
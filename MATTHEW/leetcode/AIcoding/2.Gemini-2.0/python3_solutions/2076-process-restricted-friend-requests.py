class Solution:
    def processRestrictedFriendRequests(self, n: int, requests: List[List[int]], restrictions: List[List[int]]) -> List[bool]:
        parent = list(range(n))

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j
                return True
            return False

        ans = []
        for u, v in requests:
            root_u = find(u)
            root_v = find(v)

            valid = True
            for x, y in restrictions:
                root_x = find(x)
                root_y = find(y)
                if (root_x == root_u and root_y == root_v) or (root_x == root_v and root_y == root_u):
                    valid = False
                    break

            if valid:
                ans.append(union(u, v))
            else:
                ans.append(False)

        return ans
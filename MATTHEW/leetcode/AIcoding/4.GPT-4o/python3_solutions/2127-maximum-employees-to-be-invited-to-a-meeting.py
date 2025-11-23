class Solution:
    def maximumInvitations(self, favorite: List[int]) -> int:
        n = len(favorite)
        visited = [False] * n
        in_cycle = [False] * n
        max_invites = 0

        def find_cycle(start):
            nonlocal max_invites
            curr = start
            path = {}
            count = 0

            while True:
                if visited[curr]:
                    if curr in path:
                        cycle_length = count - path[curr]
                        max_invites = max(max_invites, cycle_length)
                        return True
                    return False
                visited[curr] = True
                path[curr] = count
                count += 1
                curr = favorite[curr]

        for i in range(n):
            if not visited[i]:
                find_cycle(i)

        return max_invites
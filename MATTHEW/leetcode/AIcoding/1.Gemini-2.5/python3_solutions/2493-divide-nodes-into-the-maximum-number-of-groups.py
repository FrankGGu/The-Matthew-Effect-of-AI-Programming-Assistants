from collections import deque

class Solution:
    def divideNodes(self, n: int, edges: list[list[int]]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        global_visited = [False] * n
        total_max_groups = 0

        for i in range(n):
            if not global_visited[i]:
                # Step 1: BFS to find component nodes, check bipartiteness, and find one endpoint of diameter (e1)

                # dist array serves multiple purposes:
                # 1. Visited tracking for the current component's BFS (dist[u] != -1)
                # 2. Stores shortest path distance from the BFS source 'i'
                # 3. Used to check bipartiteness: adjacent nodes must have distances differing by 1
                dist = [-1] * n 

                q = deque()
                q.append(i)
                dist[i] = 0
                global_visited[i] = True # Mark as globally visited as part of this component

                e1 = i # Candidate for one endpoint of the diameter
                max_dist_from_i = 0 # Max distance from 'i' in this component

                is_bipartite = True

                while q:
                    u = q.popleft()

                    if dist[u] > max_dist_from_i:
                        max_dist_from_i = dist[u]
                        e1 = u # Update e1 if a farther node is found

                    for v in adj[u]:
                        if dist[v] == -1: # Node 'v' not yet visited in this component's BFS
                            dist[v] = dist[u] + 1
                            global_visited[v] = True # Mark globally visited
                            q.append(v)
                        elif abs(dist[u] - dist[v]) != 1: # Node 'v' already visited, check bipartiteness
                            is_bipartite = False
                            break # Found an odd cycle, impossible to group
                    if not is_bipartite:
                        break # Exit inner while loop if not bipartite

                if not is_bipartite:
                    return 0 # If any component is not bipartite, return 0 immediately

                # Step 2: Calculate the diameter of the bipartite component
                # Perform a second BFS starting from 'e1' (one endpoint of a longest path)

                dist_e1 = [-1] * n # Re-initialize dist array for this second BFS
                q_e1 = deque()
                q_e1.append(e1)
                dist_e1[e1] = 0

                diameter = 0 # This will store the maximum distance from e1, which is the diameter

                while q_e1:
                    u = q_e1.popleft()

                    if dist_e1[u] > diameter:
                        diameter = dist_e1[u] # Update diameter if a farther node is found

                    for v in adj[u]:
                        # Check if 'v' has not been visited in this BFS.
                        # Since all nodes in this component are already marked global_visited,
                        # we don't need to check global_visited[v] here.
                        # dist_e1[v] == -1 implicitly ensures we stay within the component.
                        if dist_e1[v] == -1: 
                            dist_e1[v] = dist_e1[u] + 1
                            q_e1.append(v)

                # The number of groups needed for this component is (diameter + 1)
                total_max_groups += (diameter + 1)

        return total_max_groups
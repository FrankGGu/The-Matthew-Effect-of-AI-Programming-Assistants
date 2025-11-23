from collections import deque

class Solution:
    def countOfPairs(self, n: int, x: int, y: int) -> list[int]:
        # Adjust x and y to be 0-indexed for easier array access
        # Houses are labeled 1 to n, so 0 to n-1 in code
        x_idx = x - 1
        y_idx = y - 1

        # Initialize distance matrix
        # dist[i][j] will store the shortest distance from house i to house j
        # Initialize all distances to infinity
        dist = [[float('inf')] * n for _ in range(n)]

        # Distance from a house to itself is 0
        for i in range(n):
            dist[i][i] = 0

        # For each house, run a Breadth-First Search (BFS) to find all shortest paths
        for start_node in range(n):
            q = deque([(start_node, 0)]) # (current_node, current_distance)
            visited = {start_node} # Keep track of visited nodes in the current BFS

            while q:
                curr_node, curr_dist = q.popleft()
                dist[start_node][curr_node] = curr_dist # Record the shortest distance

                # Determine neighbors of the current house
                neighbors = []

                # Standard linear connections (p, p+1)
                if curr_node > 0:
                    neighbors.append(curr_node - 1)
                if curr_node < n - 1:
                    neighbors.append(curr_node + 1)

                # Special connection (x, y)
                if curr_node == x_idx:
                    neighbors.append(y_idx)
                elif curr_node == y_idx:
                    neighbors.append(x_idx)

                # Explore unvisited neighbors
                for next_node in neighbors:
                    if next_node not in visited:
                        visited.add(next_node)
                        q.append((next_node, curr_dist + 1))

        # Count pairs for each possible distance k
        # ans[k] will store the number of pairs (i, j) such that dist(i, j) = k
        # k ranges from 1 to n-1. ans[0] will be unused.
        ans = [0] * n 

        # Iterate through all unique pairs of houses (i, j) where i < j
        for i in range(n):
            for j in range(i + 1, n):
                d = dist[i][j]
                # Only count distances within the valid range [1, n-1]
                if 1 <= d < n:
                    ans[d] += 1

        # Return the counts for distances k from 1 to n-1
        return ans[1:]
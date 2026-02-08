import heapq

class Solution:
    def trapRainWater(self, heightMap: list[list[int]]) -> int:
        if not heightMap or not heightMap[0] or len(heightMap) < 3 or len(heightMap[0]) < 3:
            return 0

        m, n = len(heightMap), len(heightMap[0])

        # visited[r][c] will be True if the cell (r, c) has been added to the min_heap
        # or processed.
        visited = [[False] * n for _ in range(m)]

        # Min-heap stores tuples: (height, row, col)
        # 'height' here represents the effective boundary height for water flowing into this cell.
        min_heap = []
        total_water = 0

        # Initialize the min-heap with all border cells.
        # These cells are the initial "walls" from which water can flow inwards.

        # Add top and bottom rows
        for j in range(n):
            heapq.heappush(min_heap, (heightMap[0][j], 0, j))
            visited[0][j] = True
            heapq.heappush(min_heap, (heightMap[m-1][j], m-1, j))
            visited[m-1][j] = True

        # Add left and right columns (excluding corners already added)
        for i in range(1, m - 1):
            heapq.heappush(min_heap, (heightMap[i][0], i, 0))
            visited[i][0] = True
            heapq.heappush(min_heap, (heightMap[i][n-1], i, n-1))
            visited[i][n-1] = True

        # Directions for neighbors: right, left, down, up
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        # Process cells from the min_heap
        while min_heap:
            # Get the cell with the minimum effective boundary height
            height, r, c = heapq.heappop(min_heap)

            # Explore its neighbors
            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                # Check if the neighbor is within bounds and not yet visited
                if 0 <= nr < m and 0 <= nc < n and not visited[nr][nc]:
                    visited[nr][nc] = True

                    # Calculate trapped water at this neighbor
                    # Water trapped is the difference between the current effective boundary height
                    # and the neighbor's actual height, if the boundary is higher.
                    total_water += max(0, height - heightMap[nr][nc])

                    # Add the neighbor to the min_heap.
                    # The new effective boundary height for this neighbor is the maximum of:
                    # 1. The current effective boundary height 'height' (water level flowing in)
                    # 2. The neighbor's actual height (if it's a higher wall)
                    # This ensures that water can only be trapped if the surrounding walls are higher.
                    heapq.heappush(min_heap, (max(height, heightMap[nr][nc]), nr, nc))

        return total_water
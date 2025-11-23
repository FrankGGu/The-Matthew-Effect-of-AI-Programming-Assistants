import heapq

class SegmentTree:
    def __init__(self, k):
        self.k = k
        self.tree = [0] * (4 * k)
        self._build(1, 0, k - 1)

    def _build(self, v, tl, tr):
        if tl == tr:
            self.tree[v] = 1  # Server is initially available
        else:
            tm = (tl + tr) // 2
            self._build(2 * v, tl, tm)
            self._build(2 * v + 1, tm + 1, tr)
            self.tree[v] = self.tree[2 * v] + self.tree[2 * v + 1]

    def update(self, v, tl, tr, pos, val):
        if tl == tr:
            self.tree[v] = val
        else:
            tm = (tl + tr) // 2
            if pos <= tm:
                self.update(2 * v, tl, tm, pos, val)
            else:
                self.update(2 * v + 1, tm + 1, tr, pos, val)
            self.tree[v] = self.tree[2 * v] + self.tree[2 * v + 1]

    def query_first_available(self, v, tl, tr, query_L, query_R):
        # If the current segment is outside the query range, or has no available servers
        if tr < query_L or tl > query_R or self.tree[v] == 0:
            return -1

        # If it's a leaf node and it's available (tree[v] must be 1)
        if tl == tr:
            return tl

        tm = (tl + tr) // 2

        # Try to find in the left child's range
        res = self.query_first_available(2 * v, tl, tm, query_L, query_R)
        if res != -1:
            return res

        # If not found in the left, try the right child's range
        res = self.query_first_available(2 * v + 1, tm + 1, tr, query_L, query_R)
        return res

class Solution:
    def busiestServers(self, k: int, arrival: list[int], load: list[int]) -> list[int]:
        server_counts = [0] * k
        busy_servers_heap = []  # Stores (finish_time, server_id)

        segment_tree = SegmentTree(k)

        for i in range(len(arrival)):
            current_arrival = arrival[i]
            current_load = load[i]

            # Release servers that have finished their tasks by current_arrival time
            while busy_servers_heap and busy_servers_heap[0][0] <= current_arrival:
                finish_time, server_id = heapq.heappop(busy_servers_heap)
                segment_tree.update(1, 0, k - 1, server_id, 1) # Mark server as available

            start_server_idx = i % k
            chosen_server_id = -1

            # Try to find an available server from start_server_idx to k-1
            chosen_server_id = segment_tree.query_first_available(1, 0, k - 1, start_server_idx, k - 1)

            if chosen_server_id == -1:
                # If no server found in [start_server_idx, k-1], try from 0 to start_server_idx-1
                # This handles the wrap-around case
                chosen_server_id = segment_tree.query_first_available(1, 0, k - 1, 0, start_server_idx - 1)

            if chosen_server_id != -1:
                # Assign request to chosen_server_id
                server_counts[chosen_server_id] += 1
                segment_tree.update(1, 0, k - 1, chosen_server_id, 0) # Mark server as busy
                heapq.heappush(busy_servers_heap, (current_arrival + current_load, chosen_server_id))

        max_requests = 0
        if server_counts:
            max_requests = max(server_counts)

        result = []
        for j in range(k):
            if server_counts[j] == max_requests:
                result.append(j)

        return result
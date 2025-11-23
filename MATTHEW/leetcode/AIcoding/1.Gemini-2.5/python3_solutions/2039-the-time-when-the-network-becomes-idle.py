import collections

class Solution:
    def networkBecomesIdle(self, n: int, edges: list[list[int]], patience: list[int]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        dist = [-1] * n
        q = collections.deque([(0, 0)]) # (node, distance from master)
        dist[0] = 0

        head = 0
        while q:
            u, d = q.popleft()
            for v in adj[u]:
                if dist[v] == -1:
                    dist[v] = d + 1
                    q.append((v, d + 1))

        max_last_packet_arrival_time = 0

        for i in range(1, n): # Iterate through data servers (1 to n-1)
            d_i = dist[i]
            p_i = patience[i]

            round_trip_time = 2 * d_i

            last_send_time_i = 0
            if round_trip_time > p_i:
                # Server i will retransmit if the reply for a packet hasn't arrived
                # by patience[i] time after sending.
                # The reply for the initial packet arrives at round_trip_time.
                # Server i sends packets at 0, p_i, 2*p_i, ...
                # It stops sending when k*p_i >= round_trip_time.
                # So the last packet is sent at k_max * p_i, where k_max * p_i < round_trip_time.
                # k_max = floor((round_trip_time - 1) / p_i)
                k_max = (round_trip_time - 1) // p_i
                last_send_time_i = k_max * p_i

            # The time when the last packet sent by server i arrives at the master server (server 0).
            # This packet was sent at last_send_time_i and takes d_i time to travel.
            server_i_completion_time = last_send_time_i + d_i

            max_last_packet_arrival_time = max(max_last_packet_arrival_time, server_i_completion_time)

        # The network becomes idle at the moment *after* the last packet has arrived.
        # If the last packet arrives at time T, the network is busy up to T.
        # It becomes idle at T + 1.
        return max_last_packet_arrival_time + 1
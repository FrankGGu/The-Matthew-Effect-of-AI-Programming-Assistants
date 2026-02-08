class Solution:
    def busiestServers(self, k: int, arrival: List[int], load: List[int]) -> List[int]:
        from sortedcontainers import SortedList

        n = len(arrival)
        count = [0] * k
        free_servers = SortedList(range(k))
        busy_servers = []

        for i in range(n):
            while busy_servers and busy_servers[0][0] <= arrival[i]:
                _, server = busy_servers.pop(0)
                free_servers.add(server)

            if not free_servers:
                continue

            server = free_servers.bisect_left(i % k)
            if server == len(free_servers):
                server = 0

            chosen_server = free_servers[server]
            count[chosen_server] += 1
            busy_servers.append((arrival[i] + load[i], chosen_server))
            busy_servers.sort()
            free_servers.remove(chosen_server)

        max_requests = max(count)
        return [i for i in range(k) if count[i] == max_requests]
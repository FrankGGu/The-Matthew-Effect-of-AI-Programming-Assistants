from collections import defaultdict

class Solution:
    def countServers(self, n: int, logs: list[list[int]], x: int, queries: list[int]) -> list[int]:
        log_dict = defaultdict(int)
        for time in logs:
            log_dict[time[1]] += 1

        result = []
        for query in queries:
            count = 0
            for server, freq in log_dict.items():
                if query - x <= server <= query:
                    count += freq
            result.append(n - count)

        return result
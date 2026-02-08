class Solution:
    def defendSpaceCity(self, time: List[int], position: List[int]) -> int:
        n = len(time)
        events = []
        for i in range(n):
            events.append((position[i], time[i]))
        events.sort()

        res = 0
        i = 0
        while i < n:
            pos = events[i][0]
            j = i
            while j < n and events[j][0] == pos:
                j += 1
            same_pos = [t for (p, t) in events[i:j]]
            same_pos.sort()
            m = len(same_pos)
            dp = [[float('inf')] * 3 for _ in range(m + 1)]
            dp[0][0] = 0
            for k in range(1, m + 1):
                t = same_pos[k - 1]
                for prev in range(3):
                    if dp[k - 1][prev] == float('inf'):
                        continue
                    for curr in range(3):
                        cost = 0
                        if curr == 0:
                            cost = 2
                        elif curr == 1:
                            cost = 3
                        elif curr == 2:
                            cost = 4
                        if prev == 2 and curr == 2:
                            cost -= 1
                        if curr >= 1 and t > 1:
                            if k >= 2 and same_pos[k - 2] == t - 1:
                                pass
                            else:
                                continue
                        dp[k][curr] = min(dp[k][curr], dp[k - 1][prev] + cost)
            res += min(dp[m][0], dp[m][1], dp[m][2])
            i = j
        return res
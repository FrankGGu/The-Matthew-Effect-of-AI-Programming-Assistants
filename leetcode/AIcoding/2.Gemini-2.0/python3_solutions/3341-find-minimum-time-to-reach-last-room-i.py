class Solution:
    def minTimeToReachLastRoom(self, capacity: list[int]) -> int:
        n = len(capacity)
        time = 0
        for i in range(n - 1):
            time += 1
            if time <= capacity[i]:
                time = capacity[i] + 1
        return time
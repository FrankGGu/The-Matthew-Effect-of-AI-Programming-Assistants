class Solution:
    def maxRunningTime(self, n: int, batteries: List[int]) -> int:
        batteries.sort(reverse=True)
        for i in range(n):
            if i < len(batteries):
                batteries[i] = 0
            else:
                return 0
        batteries.sort()
        for i in range(n, len(batteries)):
            batteries[0] += batteries[i]
            batteries.sort()
        return batteries[0]
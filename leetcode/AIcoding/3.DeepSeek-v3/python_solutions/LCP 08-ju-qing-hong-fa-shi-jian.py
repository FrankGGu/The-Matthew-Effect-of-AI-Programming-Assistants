class Solution:
    def getTriggerTime(self, increase: List[List[int]], requirements: List[List[int]]) -> List[int]:
        n = len(increase)
        prefix = [[0, 0, 0] for _ in range(n + 1)]
        for i in range(1, n + 1):
            prefix[i][0] = prefix[i-1][0] + increase[i-1][0]
            prefix[i][1] = prefix[i-1][1] + increase[i-1][1]
            prefix[i][2] = prefix[i-1][2] + increase[i-1][2]

        res = []
        for req in requirements:
            c, r, h = req
            left, right = 0, n
            ans = -1
            while left <= right:
                mid = (left + right) // 2
                if prefix[mid][0] >= c and prefix[mid][1] >= r and prefix[mid][2] >= h:
                    ans = mid
                    right = mid - 1
                else:
                    left = mid + 1
            res.append(ans)
        return res
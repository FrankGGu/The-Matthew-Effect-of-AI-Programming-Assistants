class Solution:
    def countTime(self, time: str) -> int:
        ans = 1
        if time[0] == '?':
            if time[1] == '?':
                ans *= 24
            elif int(time[1]) <= 3:
                ans *= 3
            else:
                ans *= 2
        else:
            if time[1] == '?':
                if int(time[0]) < 2:
                    ans *= 10
                else:
                    ans *= 4

        if time[3] == '?':
            if time[4] == '?':
                ans *= 60
            else:
                ans *= 6
        else:
            if time[4] == '?':
                ans *= 10
        return ans
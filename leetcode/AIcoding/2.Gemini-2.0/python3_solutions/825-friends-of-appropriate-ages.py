class Solution:
    def numFriendRequests(self, ages: List[int]) -> int:
        count = [0] * 121
        for age in ages:
            count[age] += 1

        ans = 0
        for a in range(1, 121):
            for b in range(1, 121):
                if count[a] > 0 and count[b] > 0:
                    if b <= 0.5 * a + 7:
                        continue
                    if b > a:
                        continue
                    if b > 100 and a < 100:
                        continue
                    ans += count[a] * (count[b] - (a == b))

        return ans
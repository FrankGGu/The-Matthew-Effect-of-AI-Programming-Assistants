class Solution:
    def numFriendRequests(self, ages: List[int]) -> int:
        count = [0] * 121
        for age in ages:
            count[age] += 1

        prefix = [0] * 121
        for i in range(1, 121):
            prefix[i] = prefix[i - 1] + count[i]

        res = 0
        for age in range(15, 121):
            if count[age] == 0:
                continue
            min_age = age // 2 + 7
            res += count[age] * (prefix[age] - prefix[min_age] - 1)

        return res
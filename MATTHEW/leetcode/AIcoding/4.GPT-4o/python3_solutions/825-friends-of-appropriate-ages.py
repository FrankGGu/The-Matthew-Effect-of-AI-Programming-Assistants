class Solution:
    def numFriendRequests(self, ages: List[int]) -> int:
        def can_request(x, y):
            return not (y <= 0.5 * x + 7 or y > x or (y < 100 and x < 100))

        count = 0
        for i in range(len(ages)):
            for j in range(len(ages)):
                if i != j and can_request(ages[i], ages[j]):
                    count += 1
        return count
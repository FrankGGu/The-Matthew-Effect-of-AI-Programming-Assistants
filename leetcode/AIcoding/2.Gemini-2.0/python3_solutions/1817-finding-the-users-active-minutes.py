class Solution:
    def findingUsersActiveMinutes(self, logs: List[List[int]], k: int) -> List[int]:
        user_minutes = {}
        for user, minute in logs:
            if user not in user_minutes:
                user_minutes[user] = set()
            user_minutes[user].add(minute)

        result = [0] * k
        for user in user_minutes:
            active_minutes = len(user_minutes[user])
            if active_minutes <= k:
                result[active_minutes - 1] += 1

        return result
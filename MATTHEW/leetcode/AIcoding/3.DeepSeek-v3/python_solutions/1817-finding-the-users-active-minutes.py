class Solution:
    def findingUsersActiveMinutes(self, logs: List[List[int]], k: int) -> List[int]:
        user_activity = {}
        for user_id, time in logs:
            if user_id not in user_activity:
                user_activity[user_id] = set()
            user_activity[user_id].add(time)

        result = [0] * k
        for user in user_activity:
            uam = len(user_activity[user])
            if uam <= k:
                result[uam - 1] += 1
        return result
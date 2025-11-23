from collections import defaultdict

class Solution:
    def findingUsersActiveMinutes(self, logs: List[List[int]], k: int) -> List[int]:
        user_minutes = defaultdict(set)

        for user_id, minute in logs:
            user_minutes[user_id].add(minute)

        minute_count = [0] * k

        for minutes in user_minutes.values():
            minute_count[len(minutes) - 1] += 1

        return minute_count
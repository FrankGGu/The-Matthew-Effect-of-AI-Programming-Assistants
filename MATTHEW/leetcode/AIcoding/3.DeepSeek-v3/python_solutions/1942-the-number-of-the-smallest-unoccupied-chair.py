import heapq

class Solution:
    def smallestChair(self, times: List[List[int]], targetFriend: int) -> int:
        events = []
        for i, (arrival, leaving) in enumerate(times):
            events.append((arrival, 1, i))  # 1 represents arrival
            events.append((leaving, 0, i))  # 0 represents leaving

        events.sort()
        available_chairs = []
        next_chair = 0
        friend_chair = {}

        for time, typ, friend in events:
            if typ == 0:  # leaving
                chair = friend_chair.pop(friend)
                heapq.heappush(available_chairs, chair)
            else:  # arrival
                if available_chairs:
                    chair = heapq.heappop(available_chairs)
                else:
                    chair = next_chair
                    next_chair += 1
                friend_chair[friend] = chair
                if friend == targetFriend:
                    return chair
        return -1
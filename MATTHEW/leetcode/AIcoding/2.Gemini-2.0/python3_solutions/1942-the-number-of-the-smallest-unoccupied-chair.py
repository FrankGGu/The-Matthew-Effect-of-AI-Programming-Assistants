import heapq

class Solution:
    def smallestChair(self, times: list[list[int]], targetFriend: int) -> int:
        arrivals = sorted([(times[i][0], i) for i in range(len(times))])

        available_chairs = []
        occupied_chairs = []
        friend_arrival = times[targetFriend][0]

        chair_map = {}

        for arrival_time, friend_id in arrivals:
            while occupied_chairs and occupied_chairs[0][0] <= arrival_time:
                _, chair = heapq.heappop(occupied_chairs)
                heapq.heappush(available_chairs, chair)

            if available_chairs:
                chair = heapq.heappop(available_chairs)
            else:
                chair = len(occupied_chairs) + len(available_chairs)

            chair_map[friend_id] = chair
            heapq.heappush(occupied_chairs, (times[friend_id][1], chair))

            if friend_id == targetFriend:
                return chair_map[targetFriend]
from collections import deque

class Solution:
    def watchedVideosByFriends(self, watchedVideos: List[List[str]], friends: List[List[int]], id: int, level: int) -> List[str]:
        visited = [False] * len(friends)
        queue = deque()
        queue.append((id, 0))
        visited[id] = True
        target_level_friends = []

        while queue:
            current_id, current_level = queue.popleft()
            if current_level == level:
                target_level_friends.append(current_id)
                continue
            for friend in friends[current_id]:
                if not visited[friend]:
                    visited[friend] = True
                    queue.append((friend, current_level + 1))

        video_count = {}
        for friend in target_level_friends:
            for video in watchedVideos[friend]:
                video_count[video] = video_count.get(video, 0) + 1

        sorted_videos = sorted(video_count.keys(), key=lambda x: (video_count[x], x))
        return sorted_videos
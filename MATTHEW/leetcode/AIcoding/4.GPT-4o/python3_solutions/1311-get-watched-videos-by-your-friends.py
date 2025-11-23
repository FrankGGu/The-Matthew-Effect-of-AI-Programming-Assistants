from collections import defaultdict, Counter
from collections import deque

class Solution:
    def watchedVideosByFriends(self, watchedVideos: List[List[str]], friends: List[List[int]], id: int, level: int) -> List[str]:
        queue = deque([id])
        visited = set([id])
        current_level = 0

        while queue and current_level < level:
            current_level += 1
            for _ in range(len(queue)):
                friend = queue.popleft()
                for f in friends[friend]:
                    if f not in visited:
                        visited.add(f)
                        queue.append(f)

        video_count = Counter()
        while queue:
            friend = queue.popleft()
            for video in watchedVideos[friend]:
                video_count[video] += 1

        return sorted(video_count.keys())
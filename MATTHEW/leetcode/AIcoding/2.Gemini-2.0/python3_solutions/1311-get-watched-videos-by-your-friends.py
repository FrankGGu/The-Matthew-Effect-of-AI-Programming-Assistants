from collections import deque

class Solution:
    def watchedVideosByFriends(self, watchedVideos: List[List[str]], friends: List[List[int]], id: int, level: int) -> List[str]:
        n = len(friends)
        visited = [False] * n
        visited[id] = True
        q = deque([id])

        for _ in range(level):
            qlen = len(q)
            for _ in range(qlen):
                curr = q.popleft()
                for neighbor in friends[curr]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        q.append(neighbor)

        watched = {}
        while q:
            curr = q.popleft()
            for video in watchedVideos[curr]:
                watched[video] = watched.get(video, 0) + 1

        result = sorted(watched.keys(), key=lambda x: (watched[x], x))
        return result
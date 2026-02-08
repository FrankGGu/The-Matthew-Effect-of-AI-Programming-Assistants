import collections

class Solution:
    def watchedVideosByFriends(self, watchedVideos: List[List[str]], friends: List[List[int]], id: int, level: int) -> List[str]:

        q = collections.deque([(id, 0)])
        visited = {id}

        friends_at_target_level = set()

        while q:
            curr_person, curr_level = q.popleft()

            if curr_level == level:
                friends_at_target_level.add(curr_person)
                # Do not explore further from this node if we've reached the target level
                # as we only care about friends *at* this level, not beyond.
                continue 

            if curr_level < level:
                for neighbor in friends[curr_person]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        q.append((neighbor, curr_level + 1))

        video_counts = collections.Counter()
        for friend_id in friends_at_target_level:
            for video in watchedVideos[friend_id]:
                video_counts[video] += 1

        result = []
        for video, count in video_counts.items():
            result.append((count, video))

        result.sort()

        return [video for count, video in result]
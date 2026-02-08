import collections

class Solution:
    def videoStitching(self, clips: list[list[int]], time: int) -> int:
        clips.sort()

        current_reach = 0
        clips_needed = 0
        i = 0
        n = len(clips)

        while current_reach < time:
            max_next_reach = current_reach

            while i < n and clips[i][0] <= current_reach:
                max_next_reach = max(max_next_reach, clips[i][1])
                i += 1

            if max_next_reach == current_reach:
                return -1

            current_reach = max_next_reach
            clips_needed += 1

        return clips_needed
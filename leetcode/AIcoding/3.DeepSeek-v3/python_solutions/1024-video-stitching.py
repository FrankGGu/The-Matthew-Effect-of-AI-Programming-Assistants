class Solution:
    def videoStitching(self, clips: List[List[int]], time: int) -> int:
        clips.sort()
        res = 0
        current_end, next_end = 0, 0
        i = 0
        n = len(clips)
        while i < n and current_end < time:
            while i < n and clips[i][0] <= current_end:
                next_end = max(next_end, clips[i][1])
                i += 1
            if current_end == next_end:
                return -1
            current_end = next_end
            res += 1
        return res if current_end >= time else -1
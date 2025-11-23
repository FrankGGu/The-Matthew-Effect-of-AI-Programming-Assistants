class Solution:
    def videoStitching(self, clips, time: int) -> int:
        clips.sort()
        res = 0
        i = 0
        n = len(clips)
        while i < n and time > 0:
            max_end = 0
            while i < n and clips[i][0] <= 0:
                max_end = max(max_end, clips[i][1])
                i += 1
            if max_end == 0:
                return -1
            res += 1
            time -= max_end
            if time <= 0:
                return res
            while i < n and clips[i][0] <= max_end:
                max_end = max(max_end, clips[i][1])
                i += 1
        return -1 if time > 0 else res
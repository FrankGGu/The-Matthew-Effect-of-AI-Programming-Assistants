class Solution:
    def videoStitching(self, clips: List[List[int]], T: int) -> int:
        clips.sort()
        end, farthest, count = 0, 0, 0
        for start, finish in clips:
            if start > end:
                if end == farthest:
                    return -1
                end = farthest
                count += 1
            if start <= end:
                farthest = max(farthest, finish)
                if end >= T:
                    return count + (1 if end < T else 0)
        return count + (1 if end < T else 0) if end >= T else -1
class Solution:
    def countTarget(self, scores: List[int], target: int) -> int:
        left = bisect.bisect_left(scores, target)
        right = bisect.bisect_right(scores, target)
        return right - left
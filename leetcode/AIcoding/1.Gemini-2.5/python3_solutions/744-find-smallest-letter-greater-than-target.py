import bisect

class Solution:
    def nextGreatestLetter(self, letters: list[str], target: str) -> str:
        idx = bisect.bisect_right(letters, target)
        if idx == len(letters):
            return letters[0]
        else:
            return letters[idx]
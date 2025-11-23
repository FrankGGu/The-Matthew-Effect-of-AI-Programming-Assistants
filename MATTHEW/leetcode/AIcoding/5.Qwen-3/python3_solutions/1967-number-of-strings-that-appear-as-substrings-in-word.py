class Solution:
    def numSimilarStrs(self, pieces: List[str], target: str) -> int:
        count = 0
        for piece in pieces:
            if piece in target:
                count += 1
        return count
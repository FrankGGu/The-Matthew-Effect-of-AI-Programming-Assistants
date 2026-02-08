class Solution:
    def closetTarget(self, words: List[str], target: str, startIndex: int) -> int:
        n = len(words)
        if target not in words:
            return -1

        distances = []
        for i in range(n):
            if words[i] == target:
                distances.append(min(abs(i - startIndex), n - abs(i - startIndex)))

        return min(distances)
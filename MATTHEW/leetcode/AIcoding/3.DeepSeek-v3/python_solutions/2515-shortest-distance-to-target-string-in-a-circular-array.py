class Solution:
    def closetTarget(self, words: List[str], target: str, startIndex: int) -> int:
        n = len(words)
        min_distance = float('inf')
        found = False

        for i in range(n):
            if words[i] == target:
                found = True
                distance = min(abs(i - startIndex), n - abs(i - startIndex))
                if distance < min_distance:
                    min_distance = distance

        return min_distance if found else -1
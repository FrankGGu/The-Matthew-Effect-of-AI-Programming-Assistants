class Solution:
    def findSequence(self, logs: list[str]) -> list[str]:
        seen = set()
        result = []
        for s in logs:
            if s not in seen:
                seen.add(s)
                result.append(s)
        return result
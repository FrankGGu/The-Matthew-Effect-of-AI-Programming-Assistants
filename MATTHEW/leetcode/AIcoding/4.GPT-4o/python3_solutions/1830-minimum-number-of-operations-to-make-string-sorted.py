class Solution:
    def minimumOperations(self, s: str) -> int:
        return len(set(s)) - 1 if len(set(s)) > 1 else 0
class Solution:
    def countSegments(self, s: str) -> int:
        return len(s.split()) if s.strip() else 0
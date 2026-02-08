class Solution:
    def buddyStrings(self, s: str, goal: str) -> bool:
        if len(s) != len(goal):
            return False

        if s == goal:
            seen = set()
            for char in s:
                if char in seen:
                    return True
                seen.add(char)
            return False

        pairs = []
        for a, b in zip(s, goal):
            if a != b:
                pairs.append((a, b))
            if len(pairs) > 2:
                return False

        return len(pairs) == 2 and pairs[0] == pairs[1][::-1]
class Solution:
    def buddyStrings(self, s: str, goal: str) -> bool:
        if len(s) != len(goal):
            return False

        if s == goal:
            return len(set(s)) < len(s)

        diff_indices = []
        for i in range(len(s)):
            if s[i] != goal[i]:
                diff_indices.append(i)

        if len(diff_indices) == 2:
            if s[diff_indices[0]] == goal[diff_indices[1]] and \
               s[diff_indices[1]] == goal[diff_indices[0]]:
                return True
            else:
                return False
        else:
            return False
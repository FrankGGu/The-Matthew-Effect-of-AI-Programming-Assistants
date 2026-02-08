class Solution:
    def orderlyQueue(self, s: str, k: int) -> str:
        if k == 1:
            n = len(s)
            min_s = s
            for i in range(n):
                # Generate all possible rotations
                # For example, if s = "abc", rotations are "abc", "bca", "cab"
                current_rotation = s[i:] + s[:i]
                if current_rotation < min_s:
                    min_s = current_rotation
            return min_s
        else:
            # If k > 1, we can effectively move any character to any position.
            # This means we can achieve any permutation of the string.
            # To get the lexicographically smallest string, we sort the characters.
            return "".join(sorted(s))
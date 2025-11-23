class Solution:
    def canTransform(self, start: str, end: str) -> bool:
        n = len(start)
        i, j = 0, 0

        while i < n and j < n:
            # Skip 'X' characters in start string
            while i < n and start[i] == 'X':
                i += 1
            # Skip 'X' characters in end string
            while j < n and end[j] == 'X':
                j += 1

            # If one pointer reached the end but the other didn't,
            # or both reached the end, break the loop.
            if i == n or j == n:
                break

            # If non-'X' characters don't match, transformation is impossible.
            if start[i] != end[j]:
                return False

            # Check movement rules for 'L' and 'R'
            if start[i] == 'L':
                # 'L' can only move left. Its final position (j) must be
                # less than or equal to its initial position (i).
                if j > i:
                    return False
            elif start[i] == 'R':
                # 'R' can only move right. Its final position (j) must be
                # greater than or equal to its initial position (i).
                if j < i:
                    return False

            # Move to the next non-'X' character
            i += 1
            j += 1

        # After the loop, ensure both strings have been fully traversed
        # for their non-'X' characters. This means skipping any remaining 'X's.
        while i < n and start[i] == 'X':
            i += 1
        while j < n and end[j] == 'X':
            j += 1

        # If both pointers reached the end of their respective strings,
        # it means all non-'X' characters matched and followed the rules.
        return i == n and j == n
class Solution:
    def canChange(self, start: str, target: str) -> bool:
        n = len(start)
        i = 0  # Pointer for start string
        j = 0  # Pointer for target string

        while i < n or j < n:
            # Advance pointer i past any underscores in start
            while i < n and start[i] == '_':
                i += 1
            # Advance pointer j past any underscores in target
            while j < n and target[j] == '_':
                j += 1

            # If both pointers have reached the end, then all non-underscore characters matched
            if i == n and j == n:
                return True

            # If one pointer reached the end but the other hasn't, it means the non-underscore
            # character counts or sequence don't match.
            if i == n or j == n:
                return False

            # If characters at current non-underscore positions don't match
            if start[i] != target[j]:
                return False

            # Check movement constraints based on character type
            if start[i] == 'L':
                # 'L' can only move to the left.
                # This means its starting index 'i' must be greater than or equal to its target index 'j'.
                if i < j:
                    return False
            elif start[i] == 'R':
                # 'R' can only move to the right.
                # This means its starting index 'i' must be less than or equal to its target index 'j'.
                if i > j:
                    return False

            # Move to the next non-underscore character
            i += 1
            j += 1

        return True
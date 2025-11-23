class Solution:
    def minChanges(self, s: str) -> int:
        n = len(s)
        changes_to_0101 = 0
        changes_to_1010 = 0

        for i in range(n):
            # For target "0101..."
            # Even index should be '0', odd index should be '1'
            if i % 2 == 0:  # Expected '0'
                if s[i] == '1':
                    changes_to_0101 += 1
            else:  # Expected '1'
                if s[i] == '0':
                    changes_to_0101 += 1

            # For target "1010..."
            # Even index should be '1', odd index should be '0'
            if i % 2 == 0:  # Expected '1'
                if s[i] == '0':
                    changes_to_1010 += 1
            else:  # Expected '0'
                if s[i] == '1':
                    changes_to_1010 += 1

        return min(changes_to_0101, changes_to_1010)
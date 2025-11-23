class Solution:
    def minimumChanges(self, s: str) -> int:
        n = len(s)
        if n < 3:
            return 0

        changes = 0
        for i in range(n):
            if s[i] == '0':
                changes += 1

        result = float('inf')
        for k in range(3):
            count = 0
            for j in range(k, n, 3):
                if s[j] == '0':
                    count += 1
            result = min(result, count)

        return changes - result
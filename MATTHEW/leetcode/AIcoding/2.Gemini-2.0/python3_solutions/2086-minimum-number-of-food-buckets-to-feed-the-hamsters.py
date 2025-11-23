class Solution:
    def buckets(self, hamsters: str) -> int:
        n = len(hamsters)
        buckets = 0
        i = 0
        while i < n:
            if hamsters[i] == 'H':
                if i > 0 and hamsters[i-1] == 'B':
                    i += 1
                    continue
                elif i < n - 1 and hamsters[i+1] == '.':
                    buckets += 1
                    i += 2
                elif i > 0 and hamsters[i-1] == '.':
                    buckets += 1
                    i += 1
                else:
                    return -1
            else:
                i += 1
        return buckets
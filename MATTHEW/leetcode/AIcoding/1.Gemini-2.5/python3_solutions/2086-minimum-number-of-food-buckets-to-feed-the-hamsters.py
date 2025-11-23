class Solution:
    def minimumBuckets(self, hamsters: str) -> int:
        n = len(hamsters)
        s_list = list(hamsters)
        buckets = 0

        for i in range(n):
            if s_list[i] == 'H':
                # Check if already fed by a bucket to its left
                if i > 0 and s_list[i-1] == 'B':
                    continue

                # Try to place a bucket to the right
                if i + 1 < n and s_list[i+1] == '.':
                    s_list[i+1] = 'B'
                    buckets += 1
                    continue

                # If not fed by right, try to place a bucket to the left
                if i > 0 and s_list[i-1] == '.':
                    s_list[i-1] = 'B'
                    buckets += 1
                    continue

                # If neither left nor right possible, this 'H' cannot be fed
                return -1

        return buckets
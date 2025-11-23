class Solution:
    def maxPartitionsAfterOperations(self, s: str, k: int) -> int:
        n = len(s)
        ans = 1
        curr = set()
        for i in range(n):
            curr.add(s[i])
            if len(curr) > k:
                ans += 1
                curr = {s[i]}

        if ans == 1:
            return 1

        ans = 0
        for i in range(1 << n - 1):
            partitions = 1
            curr = set()
            valid = True
            for j in range(n):
                curr.add(s[j])
                if len(curr) > k:
                    valid = False
                    break
                if j < n - 1 and (i >> j) & 1:
                    partitions += 1
                    curr = set()

            if valid:
                ans = max(ans, partitions)

        partitions = 1
        curr = set()
        for i in range(n):
            curr.add(s[i])
            if len(curr) > k:
                partitions += 1
                curr = {s[i]}

        can_split = False
        for i in range(n - 1):
            if s[i] != s[i+1]:
                can_split = True
                break

        if can_split and k >= 2:
            return partitions
        else:

            partitions = 1
            curr = set()

            for i in range(n):
                curr.add(s[i])
                if len(curr) > k:
                    partitions += 1
                    curr = {s[i]}

            return partitions
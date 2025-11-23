class Solution:
    def findMinimumOperations(self, s1: str, s2: str, s3: str) -> int:
        n1 = len(s1)
        n2 = len(s2)
        n3 = len(s3)

        min_len = min(n1, n2, n3)

        max_common_prefix_len = -1

        for k in range(min_len, 0, -1):
            if s1[:k] == s2[:k] and s2[:k] == s3[:k]:
                max_common_prefix_len = k
                break

        if max_common_prefix_len == -1:
            return -1
        else:
            operations = (n1 - max_common_prefix_len) + \
                         (n2 - max_common_prefix_len) + \
                         (n3 - max_common_prefix_len)
            return operations
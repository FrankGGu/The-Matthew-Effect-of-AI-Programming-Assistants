class Solution:
    def findMinimumOperations(self, s1: str, s2: str, s3: str) -> int:
        n1, n2, n3 = len(s1), len(s2), len(s3)
        min_len = min(n1, n2, n3)

        common_len = 0
        for i in range(min_len):
            if s1[i] == s2[i] == s3[i]:
                common_len += 1
            else:
                break

        return n1 + n2 + n3 - 3 * common_len
class Solution:
    def compareVersion(self, version1: str, version2: str) -> int:
        v1_parts = version1.split('.')
        v2_parts = version2.split('.')

        n1 = len(v1_parts)
        n2 = len(v2_parts)

        max_len = max(n1, n2)

        for i in range(max_len):
            rev1 = int(v1_parts[i]) if i < n1 else 0
            rev2 = int(v2_parts[i]) if i < n2 else 0

            if rev1 < rev2:
                return -1
            elif rev1 > rev2:
                return 1

        return 0
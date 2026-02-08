class Solution:
    def compareVersion(self, version1: str, version2: str) -> int:
        v1 = list(map(int, version1.split('.')))
        v2 = list(map(int, version2.split('.')))

        len1 = len(v1)
        len2 = len(v2)

        max_len = max(len1, len2)

        for i in range(max_len):
            num1 = v1[i] if i < len1 else 0
            num2 = v2[i] if i < len2 else 0

            if num1 > num2:
                return 1
            elif num1 < num2:
                return -1

        return 0
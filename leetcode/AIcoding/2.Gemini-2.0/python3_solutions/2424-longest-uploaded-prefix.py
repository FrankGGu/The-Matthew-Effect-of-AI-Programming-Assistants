class Solution:
    def longestUploadedPrefix(self, n: int, uploads: list[int]) -> int:
        uploaded = [False] * (n + 1)
        prefix = 0
        for upload in uploads:
            uploaded[upload] = True
            while prefix + 1 <= n and uploaded[prefix + 1]:
                prefix += 1
        return prefix
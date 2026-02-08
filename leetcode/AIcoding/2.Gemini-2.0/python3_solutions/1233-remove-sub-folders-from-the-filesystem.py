class Solution:
    def removeSubfolders(self, folder: list[str]) -> list[str]:
        folder.sort()
        res = [folder[0]]
        for i in range(1, len(folder)):
            if not folder[i].startswith(res[-1] + '/'):
                res.append(folder[i])
        return res
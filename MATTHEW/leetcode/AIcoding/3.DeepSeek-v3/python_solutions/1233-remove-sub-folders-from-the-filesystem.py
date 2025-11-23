class Solution:
    def removeSubfolders(self, folder: List[str]) -> List[str]:
        folder.sort()
        res = [folder[0]]
        for f in folder[1:]:
            prev = res[-1]
            if not f.startswith(prev + '/'):
                res.append(f)
        return res
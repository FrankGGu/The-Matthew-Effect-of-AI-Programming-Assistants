class Solution:
    def removeSubfolders(self, folder: List[str]) -> List[str]:
        folder.sort()
        result = []
        prev = ""
        for f in folder:
            if not f.startswith(prev + "/"):
                result.append(f)
                prev = f
        return result
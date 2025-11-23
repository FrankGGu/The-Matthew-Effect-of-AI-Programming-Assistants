class Solution:
    def removeSubfolders(self, folders: List[str]) -> List[str]:
        folders.sort()
        result = [folders[0]]
        for folder in folders[1:]:
            if not folder.startswith(result[-1] + '/'):
                result.append(folder)
        return result
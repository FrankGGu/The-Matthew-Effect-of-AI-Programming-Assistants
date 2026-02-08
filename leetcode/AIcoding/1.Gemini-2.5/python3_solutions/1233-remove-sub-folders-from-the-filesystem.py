class Solution:
    def removeSubfolders(self, folder: list[str]) -> list[str]:
        folder.sort()

        result = []

        for f in folder:
            if not result:
                result.append(f)
            else:
                last_res_f = result[-1]
                # Check if current folder 'f' is a sub-folder of the last added root folder 'last_res_f'
                # A sub-folder path must start with the root folder's path followed by a '/'
                if not f.startswith(last_res_f + '/'):
                    result.append(f)

        return result
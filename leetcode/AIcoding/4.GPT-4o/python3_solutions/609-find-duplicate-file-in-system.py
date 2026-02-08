from collections import defaultdict

class Solution:
    def findDuplicate(self, paths: List[str]) -> List[List[str]]:
        file_map = defaultdict(list)

        for path in paths:
            parts = path.split()
            root = parts[0]
            for file in parts[1:]:
                name, content = file.split('(')
                content = content[:-1]
                file_map[content].append(f"{root}/{name}")

        return [files for files in file_map.values() if len(files) > 1]
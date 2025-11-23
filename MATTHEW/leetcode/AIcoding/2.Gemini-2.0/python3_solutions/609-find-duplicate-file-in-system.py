from collections import defaultdict

class Solution:
    def findDuplicate(self, paths: list[str]) -> list[list[str]]:
        content_map = defaultdict(list)
        for path in paths:
            parts = path.split()
            directory = parts[0]
            for i in range(1, len(parts)):
                file_info = parts[i]
                name, content = file_info.split('(')
                content = content[:-1]
                content_map[content].append(directory + '/' + name)

        result = []
        for content, files in content_map.items():
            if len(files) > 1:
                result.append(files)

        return result
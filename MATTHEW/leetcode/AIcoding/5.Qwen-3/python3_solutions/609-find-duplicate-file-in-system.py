from collections import defaultdict

class Solution:
    def findDuplicate(self, paths: List[str]) -> List[List[str]]:
        content_to_files = defaultdict(list)

        for path in paths:
            parts = path.split()
            directory = parts[0]
            for file in parts[1:]:
                start = file.find('(')
                end = file.find(')')
                filename = file[:start]
                content = file[start+1:end]
                content_to_files[content].append(directory + '/' + filename)

        result = []
        for files in content_to_files.values():
            if len(files) > 1:
                result.append(files)

        return result
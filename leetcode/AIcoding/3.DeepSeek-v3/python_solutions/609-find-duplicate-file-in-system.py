class Solution:
    def findDuplicate(self, paths: List[str]) -> List[List[str]]:
        content_map = {}

        for path in paths:
            parts = path.split()
            directory = parts[0]
            for file_info in parts[1:]:
                file_parts = file_info.split('(')
                file_name = file_parts[0]
                content = file_parts[1][:-1]
                full_path = directory + '/' + file_name
                if content not in content_map:
                    content_map[content] = []
                content_map[content].append(full_path)

        return [group for group in content_map.values() if len(group) > 1]
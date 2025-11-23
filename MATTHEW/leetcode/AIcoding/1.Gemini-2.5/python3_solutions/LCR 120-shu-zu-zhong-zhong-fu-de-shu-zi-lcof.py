import collections

class Solution:
    def findDuplicate(self, paths: list[str]) -> list[list[str]]:
        content_to_paths = collections.defaultdict(list)

        for path_entry in paths:
            parts = path_entry.split(' ')
            directory = parts[0]

            for i in range(1, len(parts)):
                file_info = parts[i]

                open_paren_idx = file_info.find('(')

                file_name = file_info[:open_paren_idx]
                content = file_info[open_paren_idx + 1 : -1]

                full_path = directory + '/' + file_name
                content_to_paths[content].append(full_path)

        result = []
        for file_list in content_to_paths.values():
            if len(file_list) > 1:
                result.append(file_list)

        return result
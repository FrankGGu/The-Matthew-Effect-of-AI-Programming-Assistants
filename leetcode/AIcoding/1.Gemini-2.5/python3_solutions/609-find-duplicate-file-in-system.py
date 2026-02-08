import collections

class Solution:
    def findDuplicate(self, paths: list[str]) -> list[list[str]]:
        content_to_paths = collections.defaultdict(list)

        for path_string in paths:
            parts = path_string.split(' ')
            directory_path = parts[0]

            for i in range(1, len(parts)):
                file_description = parts[i]

                # Find the index of '(' to separate file name and content
                open_paren_idx = file_description.find('(')

                file_name = file_description[:open_paren_idx]
                # Extract content, removing the trailing ')'
                file_content = file_description[open_paren_idx + 1:-1]

                full_path = f"{directory_path}/{file_name}"
                content_to_paths[file_content].append(full_path)

        result = []
        for paths_list in content_to_paths.values():
            if len(paths_list) > 1:
                result.append(paths_list)

        return result
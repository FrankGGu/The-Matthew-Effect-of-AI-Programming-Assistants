class Solution:
    def findDuplicate(self, paths: List[str]) -> List[List[str]]:
        content_to_files = {}
        result = []
        for path in paths:
            parts = path.split(" ")
            directory = parts[0]
            for i in range(1, len(parts)):
                file_info = parts[i]
                name_content = file_info.split("(")
                file_name = name_content[0]
                content = name_content[1][:-1]

                if content not in content_to_files:
                    content_to_files[content] = []
                content_to_files[content].append(directory + "/" + file_name)

        for content, files in content_to_files.items():
            if len(files) > 1:
                result.append(files)

        return result
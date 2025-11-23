from collections import defaultdict
from typing import List

def findDuplicate(paths: List[str]) -> List[List[str]]:
    file_map = defaultdict(list)

    for path in paths:
        parts = path.split()
        directory = parts[0]
        for file in parts[1:]:
            name, content = file.split('(')
            content = content[:-1]  # Remove the closing parenthesis
            file_map[content].append(f"{directory}/{name}")

    return [files for files in file_map.values() if len(files) > 1]
class Solution:
    def removeMethodsFromProject(self, project: str) -> str:
        import re
        lines = project.split('\n')
        result = []
        for line in lines:
            if re.match(r'^\s*def\s+', line):
                continue
            result.append(line)
        return '\n'.join(result)
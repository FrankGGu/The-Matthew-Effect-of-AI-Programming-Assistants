class Solution:
    def removeMethods(self, methods: list[str], project: list[str]) -> list[str]:
        methods_set = set(methods)
        result = []
        for line in project:
            parts = line.split('(')
            if parts and parts[0].strip() not in methods_set:
                result.append(line)
        return result
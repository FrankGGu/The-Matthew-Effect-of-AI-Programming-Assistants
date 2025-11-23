class Solution:
    def removeMethods(self, project: List[str]) -> List[str]:
        def is_method(line):
            return any(line.startswith(keyword) for keyword in ["def ", "void ", "public ", "private ", "protected ", "static ", "abstract "])

        return [line for line in project if not is_method(line)]
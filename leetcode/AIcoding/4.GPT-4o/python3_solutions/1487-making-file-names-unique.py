class Solution:
    def getFolderNames(self, names: List[str]) -> List[str]:
        seen = {}
        result = []

        for name in names:
            if name not in seen:
                result.append(name)
                seen[name] = 1
            else:
                count = seen[name]
                new_name = f"{name}({count})"
                while new_name in seen:
                    count += 1
                    new_name = f"{name}({count})"
                result.append(new_name)
                seen[new_name] = 1
                seen[name] += 1

        return result
class Solution:
    def getFolderNames(self, names: List[str]) -> List[str]:
        name_map = {}
        result = []

        for name in names:
            if name not in name_map:
                name_map[name] = 1
                result.append(name)
            else:
                k = name_map[name]
                new_name = f"{name}({k})"
                while new_name in name_map:
                    k += 1
                    new_name = f"{name}({k})"
                name_map[name] = k + 1
                name_map[new_name] = 1
                result.append(new_name)

        return result
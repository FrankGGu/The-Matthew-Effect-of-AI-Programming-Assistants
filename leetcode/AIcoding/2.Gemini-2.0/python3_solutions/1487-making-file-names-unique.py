class Solution:
    def getFolderNames(self, names: List[str]) -> List[str]:
        used = {}
        res = []
        for name in names:
            if name in used:
                k = used[name]
                new_name = f"{name}({k})"
                while new_name in used:
                    k += 1
                    new_name = f"{name}({k})"
                used[name] = k + 1
                used[new_name] = 0
                res.append(new_name)
            else:
                used[name] = 0
                res.append(name)
        return res
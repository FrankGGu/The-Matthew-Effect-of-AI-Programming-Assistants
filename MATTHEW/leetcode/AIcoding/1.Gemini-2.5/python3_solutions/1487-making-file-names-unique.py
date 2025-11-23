class Solution:
    def getFolderNames(self, names: list[str]) -> list[str]:
        seen_names = {}

        result = []

        for name in names:
            if name not in seen_names:
                result.append(name)
                seen_names[name] = 1
            else:
                k = seen_names[name]

                while True:
                    new_name = f"{name}({k})"
                    if new_name not in seen_names:
                        result.append(new_name)
                        seen_names[new_name] = 1
                        seen_names[name] = k + 1
                        break
                    else:
                        k += 1

        return result
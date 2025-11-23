class Solution:
    def findAndReplace(self, s: str, indices: list[int], sources: list[str], targets: list[str]) -> str:
        replacements_map = {}

        for i in range(len(indices)):
            idx = indices[i]
            src = sources[i]
            tgt = targets[i]

            if s[idx : idx + len(src)] == src:
                replacements_map[idx] = (src, tgt)

        result = []
        current_idx = 0

        while current_idx < len(s):
            if current_idx in replacements_map:
                src, tgt = replacements_map[current_idx]
                result.append(tgt)
                current_idx += len(src)
            else:
                result.append(s[current_idx])
                current_idx += 1

        return "".join(result)
def findReplaceString(s: str, indices: List[int], sources: List[str], targets: List[str]) -> str:
    replacements = []
    for i in range(len(indices)):
        if s[indices[i]:indices[i] + len(sources[i])] == sources[i]:
            replacements.append((indices[i], targets[i]))

    replacements.sort(key=lambda x: x[0], reverse=True)
    for index, target in replacements:
        s = s[:index] + target + s[index + len(sources[indices.index(sources[index])]):]

    return s
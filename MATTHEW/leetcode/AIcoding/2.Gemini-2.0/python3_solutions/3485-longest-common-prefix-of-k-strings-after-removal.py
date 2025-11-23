def longestCommonPrefix(strs, k):
    def commonPrefix(str1, str2):
        i = 0
        while i < min(len(str1), len(str2)) and str1[i] == str2[i]:
            i += 1
        return str1[:i]

    if not strs:
        return ""

    prefix = strs[0]
    for i in range(1, len(strs)):
        prefix = commonPrefix(prefix, strs[i])
        if not prefix:
            return ""

    if not prefix:
        return ""

    result = ""
    for i in range(len(prefix)):
        count = 0
        for s in strs:
            temp_strs = list(strs)
            temp_strs.remove(s)
            can_remove = True

            for t in temp_strs:
                if not t.startswith(prefix[:i+1]):
                    can_remove = False
                    break

            if can_remove:
                count+=1

        if len(strs) - count <= k:
            result = prefix[:i+1]
        else:
            break

    return result
def kmp_table(w):
    T = [0] * len(w)
    pos = 1
    cnd = 0
    while pos < len(w):
        if w[pos] == w[cnd]:
            T[pos] = cnd + 1
            pos += 1
            cnd += 1
        elif cnd > 0:
            cnd = T[cnd-1]
        else:
            pos += 1
    return T

def kmp_match(s, w):
    T = kmp_table(w)
    i = 0
    j = 0
    count = 0
    while i < len(s):
        if s[i] == w[j]:
            i += 1
            j += 1
            if j == len(w):
                count += 1
                j = T[j-1]
        elif j > 0:
            j = T[j-1]
        else:
            i += 1
    return count

def countMatchingSubarrays(nums, pattern):
    n = len(nums)
    m = len(pattern)
    s = []
    for i in range(n - 1):
        if nums[i+1] > nums[i]:
            s.append(1)
        elif nums[i+1] < nums[i]:
            s.append(-1)
        else:
            s.append(0)

    return kmp_match(s, pattern)
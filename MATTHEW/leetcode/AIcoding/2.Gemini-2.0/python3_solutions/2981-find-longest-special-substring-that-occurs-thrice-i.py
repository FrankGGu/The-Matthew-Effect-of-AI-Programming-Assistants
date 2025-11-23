def longestSpecialSubstring(s: str) -> int:
    n = len(s)
    ans = -1
    for length in range(n, 0, -1):
        count = {}
        for i in range(n - length + 1):
            sub = s[i:i+length]
            if len(set(sub)) == 1:
                if sub in count:
                    count[sub] += 1
                else:
                    count[sub] = 1
        for sub, cnt in count.items():
            if cnt >= 3:
                return length
    return ans
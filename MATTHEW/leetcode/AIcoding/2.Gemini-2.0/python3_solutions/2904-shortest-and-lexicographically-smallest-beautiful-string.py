def shortestBeautifulSubstring(s: str, k: int) -> str:
    n = len(s)
    ans = ""
    l = 0
    count = 0
    for r in range(n):
        if s[r] == '1':
            count += 1
        while count == k:
            if not ans or (r - l + 1) < len(ans) or ((r - l + 1) == len(ans) and s[l:r+1] < ans):
                ans = s[l:r+1]
            if s[l] == '1':
                count -= 1
            l += 1
    return ans
def longestSpecialSubstring(s: str, k: int) -> int:
    n = len(s)
    ans = 0
    for c in set(s):
        l, r = 0, 0
        cnt = 0
        length = 0
        while r < n:
            if s[r] == c:
                length += 1
            else:
                length = 0
            if length >= k:
                cnt += 1
                length = 0
            r += 1
        if cnt >= 3:
            ans = max(ans, k)

    def count_substrings(length):
        cnt = 0
        for c in set(s):
            l, r = 0, 0
            cur_len = 0
            while r < n:
                if s[r] == c:
                    cur_len += 1
                else:
                    cur_len = 0
                if cur_len >= length:
                    cnt += 1
                    cur_len = 0
                r += 1
        return cnt

    low, high = 0, n // 3
    while low <= high:
        mid = (low + high) // 2
        if count_substrings(mid) >= 3:
            ans = mid
            low = mid + 1
        else:
            high = mid - 1

    return ans
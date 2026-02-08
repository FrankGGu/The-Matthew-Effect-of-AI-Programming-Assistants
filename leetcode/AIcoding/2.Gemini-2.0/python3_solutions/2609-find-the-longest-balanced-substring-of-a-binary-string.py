def findTheLongestBalancedSubstring(s: str) -> int:
    max_len = 0
    for i in range(len(s)):
        for j in range(i + 1, len(s) + 1):
            sub = s[i:j]
            zeros = sub.count('0')
            ones = sub.count('1')
            if zeros == ones and all(sub[k] == '0' for k in range(zeros)) and all(sub[zeros + k] == '1' for k in range(ones)):
                max_len = max(max_len, len(sub))
    return max_len
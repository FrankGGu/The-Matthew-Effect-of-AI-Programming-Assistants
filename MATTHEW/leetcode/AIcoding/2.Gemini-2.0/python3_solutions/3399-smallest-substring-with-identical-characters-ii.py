from collections import defaultdict

def smallestSubstring(s, k):
    n = len(s)
    ans = -1
    for i in range(n):
        freq = defaultdict(int)
        count = 0
        for j in range(i, n):
            freq[s[j]] += 1
            if freq[s[j]] == k:
                count += 1
            if count > 0:
                if ans == -1 or j - i + 1 < ans:
                    ans = j - i + 1
                break
    return ans
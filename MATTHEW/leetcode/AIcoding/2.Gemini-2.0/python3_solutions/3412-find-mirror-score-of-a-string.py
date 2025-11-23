def mirrorScore(s: str) -> int:
    n = len(s)
    score = 0
    for i in range(n // 2):
        if s[i] == s[n - 1 - i]:
            score += 2
        else:
            break
    if n % 2 == 1:
        return score + 1
    else:
        return score
def crackPassword(password: str) -> str:
    n = len(password)
    for i in range(1, n + 1):
        prefix = password[:i]
        if password.startswith(prefix * ((n + i - 1) // i)):
            return prefix
    return password
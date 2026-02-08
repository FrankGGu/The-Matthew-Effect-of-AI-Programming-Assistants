def findKthCharacter(n: int, k: int) -> str:
    s = "0"
    for _ in range(n - 1):
        temp = ""
        for char in s:
            if char == "0":
                temp += "1"
            else:
                temp += "0"
        s += temp
    return s[k - 1]
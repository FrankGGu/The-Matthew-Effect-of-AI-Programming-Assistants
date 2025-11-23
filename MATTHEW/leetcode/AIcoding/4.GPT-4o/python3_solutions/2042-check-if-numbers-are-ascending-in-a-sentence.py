def areNumbersAscending(s: str) -> bool:
    words = s.split()
    prev_num = -1
    for word in words:
        if word.isdigit():
            num = int(word)
            if num <= prev_num:
                return False
            prev_num = num
    return True
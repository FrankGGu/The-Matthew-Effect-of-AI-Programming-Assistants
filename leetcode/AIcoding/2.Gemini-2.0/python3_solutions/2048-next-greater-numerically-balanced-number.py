def nextBeautifulNumber(n: int) -> int:
    def is_balanced(num: int) -> bool:
        counts = {}
        s = str(num)
        for digit in s:
            counts[digit] = counts.get(digit, 0) + 1
        for digit, count in counts.items():
            if int(digit) != count:
                return False
        return True

    n += 1
    while True:
        if is_balanced(n):
            return n
        n += 1
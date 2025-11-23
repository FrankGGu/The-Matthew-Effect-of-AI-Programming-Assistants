def sumOfEncryptedIntegers(s: str) -> int:
    return sum(int(num) for num in s.split() if num.isdigit())
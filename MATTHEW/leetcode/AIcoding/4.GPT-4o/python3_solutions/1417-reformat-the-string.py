def reformat(s: str) -> str:
    letters = [c for c in s if c.isalpha()]
    digits = [c for c in s if c.isdigit()]

    if abs(len(letters) - len(digits)) > 1:
        return ""

    result = []
    if len(letters) > len(digits):
        result.append(letters.pop())

    while letters or digits:
        if digits:
            result.append(digits.pop())
        if letters:
            result.append(letters.pop())

    return ''.join(result)
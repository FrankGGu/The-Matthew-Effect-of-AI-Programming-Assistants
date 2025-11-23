def clear_digits(n: int, k: int) -> int:
    s = str(n)
    stack = []
    for digit in s:
        while stack and k > 0 and stack[-1] > digit:
            stack.pop()
            k -= 1
        stack.append(digit)

    while k > 0:
        stack.pop()
        k -= 1

    result = "".join(stack)
    result = result.lstrip('0')
    return int(result) if result else 0
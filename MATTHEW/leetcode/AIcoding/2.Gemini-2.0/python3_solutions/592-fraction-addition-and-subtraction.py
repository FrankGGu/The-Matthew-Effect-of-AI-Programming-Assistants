def fractionAddition(expression: str) -> str:
    i = 0
    sign = 1
    num = 0
    den = 1
    res_num = 0
    res_den = 1
    while i < len(expression):
        if expression[i] == '+' or expression[i] == '-':
            sign = 1 if expression[i] == '+' else -1
            i += 1

        num = 0
        while i < len(expression) and expression[i].isdigit():
            num = num * 10 + int(expression[i])
            i += 1

        i += 1

        den = 0
        while i < len(expression) and expression[i].isdigit():
            den = den * 10 + int(expression[i])
            i += 1

        res_num = res_num * den + num * res_den * sign
        res_den *= den

    def gcd(a, b):
        while b:
            a, b = b, a % b
        return a

    common = gcd(abs(res_num), res_den)
    res_num //= common
    res_den //= common

    return str(res_num) + '/' + str(res_den)
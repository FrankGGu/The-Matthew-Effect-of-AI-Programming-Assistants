def reverseParentheses(s: str) -> str:
    stack = []
    for i, char in enumerate(s):
        if char == '(':
            stack.append(i)
        elif char == ')':
            start = stack.pop()
            sub = list(s[start+1:i])
            sub.reverse()
            s = s[:start] + "".join(sub) + s[i+1:]
    return s.replace('(', '').replace(')', '')
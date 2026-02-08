def dailyTemperatures(T):
    n = len(T)
    res = [0] * n
    stack = []

    for i in range(n):
        while stack and T[i] > T[stack[-1]]:
            idx = stack.pop()
            res[idx] = i - idx
        stack.append(i)

    return res
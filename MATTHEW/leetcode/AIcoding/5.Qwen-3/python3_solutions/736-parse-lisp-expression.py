class Solution:
    def parse(self, expression: str) -> int:
        from collections import deque

        def tokenize(s):
            tokens = []
            i = 0
            while i < len(s):
                if s[i] == ' ':
                    i += 1
                elif s[i] == '(' or s[i] == ')':
                    tokens.append(s[i])
                    i += 1
                else:
                    j = i
                    while j < len(s) and s[j] not in '() ':
                        j += 1
                    tokens.append(s[i:j])
                    i = j
            return tokens

        def evaluate(tokens, env):
            if tokens[0] == '(':
                tokens.popleft()
                if tokens[0] == 'let':
                    tokens.popleft()
                    new_env = env.copy()
                    while tokens[0] != ')':
                        var = tokens.popleft()
                        if tokens[0] == ')':
                            return evaluate([var], new_env)
                        val = evaluate(tokens, new_env)
                        new_env[var] = val
                    tokens.popleft()
                    return evaluate(tokens, new_env)
                elif tokens[0] == 'add':
                    tokens.popleft()
                    a = evaluate(tokens, env)
                    b = evaluate(tokens, env)
                    return a + b
                elif tokens[0] == 'mult':
                    tokens.popleft()
                    a = evaluate(tokens, env)
                    b = evaluate(tokens, env)
                    return a * b
            else:
                if tokens[0][0] == '-':
                    return -int(tokens.popleft())
                else:
                    return int(tokens.popleft())

        tokens = deque(tokenize(expression))
        return evaluate(tokens, {})
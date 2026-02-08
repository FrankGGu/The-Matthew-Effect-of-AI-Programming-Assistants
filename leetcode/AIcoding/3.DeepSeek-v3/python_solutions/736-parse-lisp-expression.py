class Solution:
    def evaluate(self, expression: str) -> int:
        def parse(s, env):
            if s[0] != '(':
                if s[0] == '-' or s[0].isdigit():
                    return int(s)
                else:
                    return env[s]
            s = s[1:-1]
            tokens = tokenize(s)
            if tokens[0] == 'let':
                new_env = env.copy()
                i = 1
                while i < len(tokens) - 1:
                    var = tokens[i]
                    val = parse(tokens[i+1], new_env)
                    new_env[var] = val
                    i += 2
                return parse(tokens[-1], new_env)
            elif tokens[0] == 'add':
                return parse(tokens[1], env) + parse(tokens[2], env)
            elif tokens[0] == 'mult':
                return parse(tokens[1], env) * parse(tokens[2], env)

        def tokenize(s):
            tokens = []
            balance = 0
            token = []
            for c in s:
                if c == '(':
                    balance += 1
                elif c == ')':
                    balance -= 1
                if balance == 0 and c == ' ':
                    tokens.append(''.join(token))
                    token = []
                    continue
                token.append(c)
            if token:
                tokens.append(''.join(token))
            return tokens

        return parse(expression, {})
class Solution:
    def evaluate(self, expression: str) -> int:
        def eval_expr(expr, env):
            if expr[0] == '(':
                expr = expr[1:-1]
                parts = expr.split(' ', 1)
                op = parts[0]
                if op == 'let':
                    sub_expr = parts[1]
                    vars = []
                    vals = []
                    while True:
                        parts = sub_expr.split(' ', 2)
                        if len(parts) < 2:
                            return eval_expr(sub_expr, env)
                        var = parts[0]
                        val_expr = parts[1]
                        if ' ' in val_expr:
                            val_expr, sub_expr = val_expr.split(' ', 1)
                        else:
                            sub_expr = ''
                        vars.append(var)
                        vals.append(eval_expr(val_expr, env))
                        if not sub_expr:
                            break
                    new_env = env.copy()
                    for var, val in zip(vars, vals):
                        new_env[var] = val
                    return eval_expr(sub_expr, new_env)
                elif op == 'add':
                    expr1, expr2 = parts[1].split(' ', 1)
                    return eval_expr(expr1, env) + eval_expr(expr2, env)
                elif op == 'mult':
                    expr1, expr2 = parts[1].split(' ', 1)
                    return eval_expr(expr1, env) * eval_expr(expr2, env)
            else:
                if expr.isdigit() or expr[0] == '-':
                    return int(expr)
                else:
                    return env[expr]

        return eval_expr(expression, {})
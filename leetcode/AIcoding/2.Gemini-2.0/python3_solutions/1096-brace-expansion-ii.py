class Solution:
    def braceExpansionII(self, expression: str) -> list[str]:
        def parse(s):
            res = [set()]
            i = 0
            while i < len(s):
                if s[i] == '{':
                    j = i + 1
                    cnt = 1
                    while j < len(s) and cnt > 0:
                        if s[j] == '{':
                            cnt += 1
                        elif s[j] == '}':
                            cnt -= 1
                        j += 1
                    options = parse(s[i + 1:j - 1])
                    new_res = []
                    for r in res:
                        for option in options:
                            new_res.append(r | option)
                    res = new_res
                    i = j
                elif s[i] == ',':
                    res.append(set())
                    i += 1
                else:
                    j = i
                    while j < len(s) and s[j].isalpha():
                        j += 1
                    for r in res:
                        r.add(s[i:j])
                    i = j
            return res

        result = set()
        for r in parse(expression):
            result.update(r)
        return sorted(list(result))
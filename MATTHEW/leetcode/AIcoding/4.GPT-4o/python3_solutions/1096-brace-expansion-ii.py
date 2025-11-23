from typing import List
import itertools

class Solution:
    def braceExpansionII(self, expression: str) -> List[str]:
        def parse(s):
            stack = []
            current = []
            i = 0
            while i < len(s):
                if s[i] == '{':
                    j = i + 1
                    count = 1
                    while j < len(s) and count > 0:
                        if s[j] == '{':
                            count += 1
                        elif s[j] == '}':
                            count -= 1
                        j += 1
                    current.append(parse(s[i + 1:j - 1]))
                    i = j
                elif s[i] == ',':
                    i += 1
                else:
                    j = i
                    while j < len(s) and s[j] not in '{},':
                        j += 1
                    current.append(s[i:j])
                    i = j
            return current

        def combine(sets):
            result = set()
            for prod in itertools.product(*sets):
                result.add(''.join(prod))
            return sorted(result)

        parsed = parse(expression)
        return combine(parsed)
class Solution:
    def evaluate(self, s: str, knowledge: list[list[str]]) -> str:
        knowledge_map = {k: v for k, v in knowledge}

        result = []
        in_bracket = False
        current_key_chars = []

        for char in s:
            if char == '(':
                in_bracket = True
                current_key_chars = []
            elif char == ')':
                in_bracket = False
                key = "".join(current_key_chars)
                value = knowledge_map.get(key, "?")
                result.append(value)
            else:
                if in_bracket:
                    current_key_chars.append(char)
                else:
                    result.append(char)

        return "".join(result)
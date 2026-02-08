class Solution:
    def evaluate(self, s: str, knowledge: List[List[str]]) -> str:
        knowledge_dict = {key: value for key, value in knowledge}
        result = []
        i = 0
        while i < len(s):
            if s[i] == '(':
                j = i
                while s[j] != ')':
                    j += 1
                key = s[i + 1:j]
                result.append(knowledge_dict.get(key, '?'))
                i = j + 1
            else:
                result.append(s[i])
                i += 1
        return ''.join(result)
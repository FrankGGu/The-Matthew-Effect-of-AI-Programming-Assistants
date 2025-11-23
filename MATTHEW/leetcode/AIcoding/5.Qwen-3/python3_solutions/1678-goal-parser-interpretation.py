class Solution:
    def interpret(self, command: str) -> str:
        result = []
        i = 0
        while i < len(command):
            if command[i] == 'G':
                result.append('G')
                i += 1
            elif command[i] == '(' and command[i+1] == ')':
                result.append('o')
                i += 2
            else:
                result.append('a')
                i += 4
        return ''.join(result)
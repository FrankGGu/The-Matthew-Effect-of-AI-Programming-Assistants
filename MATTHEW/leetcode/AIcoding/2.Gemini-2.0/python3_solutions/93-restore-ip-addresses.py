class Solution:
    def restoreIpAddresses(self, s: str) -> list[str]:
        def isValid(s):
            if not s:
                return False
            if len(s) > 1 and s[0] == '0':
                return False
            num = int(s)
            return 0 <= num <= 255

        def backtrack(index, dots, current_ip, result):
            if dots == 4:
                if index == len(s):
                    result.append(current_ip[:-1])
                return

            for i in range(index, min(index + 3, len(s))):
                segment = s[index:i + 1]
                if isValid(segment):
                    backtrack(i + 1, dots + 1, current_ip + segment + ".", result)

        result = []
        backtrack(0, 0, "", result)
        return result
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def isValid(segment):
            return 0 <= int(segment) <= 255 and (segment == "0" or segment[0] != "0")

        def backtrack(start, dots, ip_address):
            if dots == 4:
                if start == len(s):
                    result.append(".".join(ip_address))
                return

            for i in range(start, min(start + 3, len(s))):
                segment = s[start:i + 1]
                if isValid(segment):
                    ip_address.append(segment)
                    backtrack(i + 1, dots + 1, ip_address)
                    ip_address.pop()

        result = []
        backtrack(0, 0, [])
        return result
class Solution:
    def validIPAddress(self, queryIP: str) -> str:
        def isIPv4(s: str) -> bool:
            parts = s.split('.')
            if len(parts) != 4:
                return False
            for part in parts:
                if not part.isdigit():
                    return False
                if part[0] == '0' and len(part) > 1:
                    return False
                num = int(part)
                if num < 0 or num > 255:
                    return False
            return True

        def isIPv6(s: str) -> bool:
            parts = s.split(':')
            if len(parts) != 8:
                return False
            for part in parts:
                if len(part) == 0 or len(part) > 4:
                    return False
                for char in part:
                    if not (char.isdigit() or 'a' <= char <= 'f' or 'A' <= char <= 'F'):
                        return False
            return True

        if '.' in queryIP:
            if isIPv4(queryIP):
                return "IPv4"
            else:
                return "Neither"
        elif ':' in queryIP:
            if isIPv6(queryIP):
                return "IPv6"
            else:
                return "Neither"
        else:
            return "Neither"
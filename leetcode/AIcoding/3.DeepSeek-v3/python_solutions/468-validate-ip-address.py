class Solution:
    def validIPAddress(self, IP: str) -> str:
        def isIPv4(s):
            try:
                num = int(s)
                return str(num) == s and 0 <= num <= 255
            except:
                return False

        def isIPv6(s):
            if len(s) > 4:
                return False
            try:
                num = int(s, 16)
                return s[0] != '-' and all(c.isdigit() or c.lower() in 'abcdef' for c in s)
            except:
                return False

        if IP.count('.') == 3:
            parts = IP.split('.')
            if all(isIPv4(part) for part in parts):
                return "IPv4"

        if IP.count(':') == 7:
            parts = IP.split(':')
            if all(isIPv6(part) for part in parts):
                return "IPv6"

        return "Neither"
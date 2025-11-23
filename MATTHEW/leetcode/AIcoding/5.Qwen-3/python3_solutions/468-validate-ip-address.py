class Solution:
    def validIPAddress(self, IP: str) -> str:
        def isIPv4(ip):
            parts = ip.split('.')
            if len(parts) != 4:
                return False
            for part in parts:
                if not part.isdigit():
                    return False
                if len(part) > 1 and part[0] == '0':
                    return False
                if int(part) < 0 or int(part) > 255:
                    return False
            return True

        def isIPv6(ip):
            parts = ip.split(':')
            if len(parts) != 8:
                return False
            hexdigits = '0123456789abcdefABCDEF'
            for part in parts:
                if len(part) < 1 or len(part) > 4:
                    return False
                for ch in part:
                    if ch not in hexdigits:
                        return False
            return True

        if '.' in IP and ':' not in IP:
            if isIPv4(IP):
                return "IPv4"
        elif ':' in IP and '.' not in IP:
            if isIPv6(IP):
                return "IPv6"
        return "Neither"
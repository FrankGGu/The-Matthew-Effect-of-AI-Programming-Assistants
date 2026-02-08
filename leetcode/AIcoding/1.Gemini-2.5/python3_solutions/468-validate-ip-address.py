class Solution:
    def validIPAddress(self, IP: str) -> str:
        def is_ipv4_part(s: str) -> bool:
            if not s or not s.isdigit():
                return False
            if len(s) > 1 and s[0] == '0':
                return False
            num = int(s)
            return 0 <= num <= 255

        def is_ipv6_part(s: str) -> bool:
            if not s or not (1 <= len(s) <= 4):
                return False
            for char in s:
                if not ('0' <= char <= '9' or 'a' <= char <= 'f' or 'A' <= char <= 'F'):
                    return False
            return True

        if '.' in IP:
            parts = IP.split('.')
            if len(parts) != 4:
                return "Neither"
            for part in parts:
                if not is_ipv4_part(part):
                    return "Neither"
            return "IPv4"
        elif ':' in IP:
            parts = IP.split(':')
            if len(parts) != 8:
                return "Neither"
            for part in parts:
                if not is_ipv6_part(part):
                    return "Neither"
            return "IPv6"
        else:
            return "Neither"
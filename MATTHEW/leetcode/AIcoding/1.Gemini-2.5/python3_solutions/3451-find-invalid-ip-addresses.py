class Solution:
    def validate_ipv4_segment(self, segment: str) -> bool:
        if not segment or len(segment) > 3:
            return False
        if len(segment) > 1 and segment[0] == '0':
            return False
        for char in segment:
            if not '0' <= char <= '9':
                return False

        num = int(segment)
        return 0 <= num <= 255

    def validate_ipv6_segment(self, segment: str) -> bool:
        if not segment or len(segment) > 4:
            return False

        hex_chars = "0123456789abcdefABCDEF"
        for char in segment:
            if char not in hex_chars:
                return False
        return True

    def validIPAddress(self, IP: str) -> str:
        if '.' in IP:
            parts = IP.split('.')
            if len(parts) != 4:
                return "Neither"
            for part in parts:
                if not self.validate_ipv4_segment(part):
                    return "Neither"
            return "IPv4"
        elif ':' in IP:
            parts = IP.split(':')
            if len(parts) != 8:
                return "Neither"
            for part in parts:
                if not self.validate_ipv6_segment(part):
                    return "Neither"
            return "IPv6"
        else:
            return "Neither"
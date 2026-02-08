class Solution:
    def validIPAddress(self, IP: str) -> str:
        def is_valid_ipv4(segment):
            if segment.isdigit() and 0 <= int(segment) <= 255:
                return str(int(segment)) == segment
            return False

        def is_valid_ipv6(segment):
            return len(segment) > 0 and len(segment) <= 4 and all(c in '0123456789abcdefABCDEF' for c in segment)

        if '.' in IP:
            segments = IP.split('.')
            if len(segments) == 4 and all(is_valid_ipv4(seg) for seg in segments):
                return "IPv4"
        elif ':' in IP:
            segments = IP.split(':')
            if len(segments) == 8 and all(is_valid_ipv6(seg) for seg in segments):
                return "IPv6"
        return "Neither"
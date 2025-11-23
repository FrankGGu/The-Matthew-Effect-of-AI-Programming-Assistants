class Solution:
    def invalidIPAddress(self, queryIP: str) -> List[str]:
        def isValidIPv4(segment):
            if not segment.isdigit() or not 0 <= int(segment) <= 255:
                return False
            if segment[0] == '0' and len(segment) > 1:
                return False
            return True

        def isValidIPv6(segment):
            if len(segment) > 4 or not all(c in '0123456789abcdefABCDEF' for c in segment):
                return False
            return True

        parts = queryIP.split('.')
        if len(parts) == 4 and all(isValidIPv4(part) for part in parts):
            return []

        parts = queryIP.split(':')
        if len(parts) == 8 and all(isValidIPv6(part) for part in parts):
            return []

        return [queryIP]
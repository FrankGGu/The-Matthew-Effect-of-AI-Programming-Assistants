def restoreIpAddresses(s: str) -> list[str]:
    def isValid(segment: str) -> bool:
        return len(segment) > 0 and (segment[0] != '0' or segment == '0') and int(segment) <= 255

    def backtrack(start: int, dots: int, current_ip: str, result: list[str]):
        if dots == 4:
            if start == len(s):
                result.append(current_ip[:-1])
            return

        for i in range(start, min(start + 3, len(s))):
            segment = s[start:i + 1]
            if isValid(segment):
                backtrack(i + 1, dots + 1, current_ip + segment + ".", result)

    result = []
    backtrack(0, 0, "", result)
    return result
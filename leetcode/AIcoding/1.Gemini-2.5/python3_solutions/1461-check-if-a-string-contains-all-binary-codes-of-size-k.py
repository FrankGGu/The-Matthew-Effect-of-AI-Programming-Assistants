class Solution:
    def hasAllCodes(self, s: str, k: int) -> bool:
        if len(s) < k:
            return False

        seen_codes = set()
        num_possible_codes = 1 << k

        if len(s) - k + 1 < num_possible_codes:
            return False

        for i in range(len(s) - k + 1):
            substring = s[i : i + k]
            seen_codes.add(substring)
            if len(seen_codes) == num_possible_codes:
                return True

        return False
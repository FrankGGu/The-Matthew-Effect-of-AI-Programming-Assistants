class Solution:
    def encryptString(self, s: str) -> str:
        if not s:
            return ""

        res = []
        current_char = s[0]
        count = 1

        for char in s[1:]:
            if char == current_char:
                count += 1
            else:
                res.append(f"{current_char}{count}")
                current_char = char
                count = 1
        res.append(f"{current_char}{count}")

        return "".join(res[::-1])
class Solution:
    def areAlmostEqual(self, username: str, password: str) -> bool:
        if len(username) != len(password):
            return False
        diff = []
        for i in range(len(username)):
            if username[i] != password[i]:
                diff.append(i)
                if len(diff) > 2:
                    return False
        return len(diff) == 2
class Solution:
    def encrypt(self, num: int) -> int:
        s = str(num)
        res = []
        for i in range(len(s)):
            digit = int(s[i])
            new_digit = (digit + 3) % 10
            res.append(str(new_digit))
        encrypted_num = int(''.join(res))
        return encrypted_num
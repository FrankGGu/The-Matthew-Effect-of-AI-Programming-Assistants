class Solution:
    def crackPassword(self, password: List[int]) -> str:
        password = list(map(str, password))
        from functools import cmp_to_key
        def compare(a, b):
            if a + b < b + a:
                return -1
            else:
                return 1
        password.sort(key=cmp_to_key(compare))
        return ''.join(password)
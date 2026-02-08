class Solution:
    def getSmallestString(self, s: str, k: int) -> str:
        s_list = list(s)
        for i in range(len(s_list)):
            if k <= 0:
                break
            current_char = s_list[i]
            min_char = 'a'
            diff = ord(current_char) - ord(min_char)
            if diff <= k:
                s_list[i] = min_char
                k -= diff
            else:
                new_char = chr(ord(current_char) - k)
                s_list[i] = new_char
                k = 0
        return ''.join(s_list)
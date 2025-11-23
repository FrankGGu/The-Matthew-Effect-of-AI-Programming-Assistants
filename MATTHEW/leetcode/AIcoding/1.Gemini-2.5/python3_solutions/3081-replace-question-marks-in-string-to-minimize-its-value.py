class Solution:
    def minimizeStringValue(self, s: str) -> str:
        result_list = []
        for char_code in s:
            if char_code == '?':
                result_list.append('a')
            else:
                result_list.append(char_code)

        return "".join(result_list)
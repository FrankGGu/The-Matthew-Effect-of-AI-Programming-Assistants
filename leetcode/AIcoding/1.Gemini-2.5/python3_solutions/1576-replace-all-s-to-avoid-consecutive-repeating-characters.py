class Solution:
    def replaceQuestionMarks(self, s: str) -> str:
        n = len(s)
        s_list = list(s)

        for i in range(n):
            if s_list[i] == '?':
                # Try 'a', 'b', 'c'
                for char_code in range(ord('a'), ord('d')):
                    char_to_use = chr(char_code)

                    is_valid = True

                    # Check left neighbor
                    if i > 0 and s_list[i-1] == char_to_use:
                        is_valid = False

                    # Check right neighbor only if it's not a '?'
                    # If s_list[i+1] is '?', it will be resolved later
                    # and will pick a character different from s_list[i].
                    if i < n - 1 and s_list[i+1] != '?' and s_list[i+1] == char_to_use:
                        is_valid = False

                    if is_valid:
                        s_list[i] = char_to_use
                        break 

        return "".join(s_list)
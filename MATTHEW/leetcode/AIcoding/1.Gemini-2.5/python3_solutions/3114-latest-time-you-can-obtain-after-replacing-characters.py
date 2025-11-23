class Solution:
    def maximumTime(self, time: str) -> str:
        s = list(time)

        # Process hours
        if s[0] == '?':
            if s[1] == '?':
                s[0] = '2'
                s[1] = '3'
            elif s[1] in '0123':
                s[0] = '2'
            else:  # s[1] in '456789'
                s[0] = '1'
        else:  # s[0] is a digit
            if s[1] == '?':
                if s[0] == '2':
                    s[1] = '3'
                else:  # s[0] is '0' or '1'
                    s[1] = '9'

        # Process minutes
        if s[3] == '?':
            s[3] = '5'

        if s[4] == '?':
            s[4] = '9'

        return "".join(s)
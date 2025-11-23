class Solution:
    def maximumTime(self, s: str) -> str:
        s_list = list(s)

        # Handle hours
        if s_list[0] == '?':
            # If s_list[1] is '?' or can be '0', '1', '2', '3', then s_list[0] can be '2'.
            # This gives the largest possible hour.
            if s_list[1] == '?' or s_list[1] in ['0', '1', '2', '3']:
                s_list[0] = '2'
            # Otherwise, s_list[1] is '4' through '9', so s_list[0] must be '0' or '1'.
            # To maximize, choose '1'.
            else:
                s_list[0] = '1'

        if s_list[1] == '?':
            # If s_list[0] is '2', then s_list[1] can only go up to '3'.
            if s_list[0] == '2':
                s_list[1] = '3'
            # If s_list[0] is '0' or '1', then s_list[1] can go up to '9'.
            else:
                s_list[1] = '9'

        # Handle minutes
        # The first minute digit can always be '5' to maximize.
        if s_list[3] == '?':
            s_list[3] = '5'

        # The second minute digit can always be '9' to maximize.
        if s_list[4] == '?':
            s_list[4] = '9'

        return "".join(s_list)
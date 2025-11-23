class Solution:
    def findLatestTime(self, time: str) -> str:
        hour, minute = time.split(':')
        h1, h2 = hour[0], hour[1]
        m1, m2 = minute[0], minute[1]

        if h1 == '?' and h2 == '?':
            h1 = '2'
            h2 = '3'
        elif h1 == '?':
            if h2 <= '3':
                h1 = '2'
            else:
                h1 = '0'
        elif h2 == '?':
            if h1 == '2':
                h2 = '3'
            else:
                h2 = '9'

        if m1 == '?' and m2 == '?':
            m1 = '5'
            m2 = '9'
        elif m1 == '?':
            m1 = '5'
        elif m2 == '?':
            m2 = '9'

        return f"{h1}{h2}:{m1}{m2}"
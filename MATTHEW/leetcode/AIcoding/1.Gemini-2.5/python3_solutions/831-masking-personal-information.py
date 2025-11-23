class Solution:
    def maskPII(self, s: str) -> str:
        if '@' in s:
            s_lower = s.lower()
            at_index = s_lower.find('@')
            name = s_lower[:at_index]
            domain = s_lower[at_index:]
            masked_name = name[0] + '*****' + name[-1]
            return masked_name + domain
        else:
            digits = ''.join(filter(str.isdigit, s))

            n = len(digits)
            last_four = digits[-4:]

            if n == 10:
                return '***-***-' + last_four
            elif n == 11:
                return '+*-***-***-' + last_four
            elif n == 12:
                return '+**-***-***-' + last_four
            elif n == 13:
                return '+***-***-***-' + last_four
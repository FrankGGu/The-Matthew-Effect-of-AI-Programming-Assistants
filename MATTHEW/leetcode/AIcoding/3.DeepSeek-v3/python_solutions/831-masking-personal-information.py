class Solution:
    def maskPII(self, s: str) -> str:
        if '@' in s:
            parts = s.split('@')
            name = parts[0].lower()
            domain = parts[1].lower()
            masked_name = name[0] + '*****' + name[-1]
            return masked_name + '@' + domain
        else:
            digits = [c for c in s if c.isdigit()]
            local_num = ''.join(digits[-4:])
            if len(digits) == 10:
                return '***-***-' + local_num
            else:
                country_code = '+' + '*' * (len(digits) - 10)
                return country_code + '-***-***-' + local_num
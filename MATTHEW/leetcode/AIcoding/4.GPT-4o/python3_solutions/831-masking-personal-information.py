class Solution:
    def maskPII(self, S: str) -> str:
        if '@' in S:
            local, domain = S.split('@')
            local = local.lower()
            local = local.replace('.', '')
            if len(local) > 2:
                local = local[0] + '*****' + local[-1]
            return f"{local}@{domain.lower()}"
        else:
            digits = ''.join(filter(str.isdigit, S))
            country_code = ''
            if len(digits) > 10:
                country_code = '+' + '*' * (len(digits) - 10) + '-'
            return f"{country_code}***-***-{digits[-4:]}"
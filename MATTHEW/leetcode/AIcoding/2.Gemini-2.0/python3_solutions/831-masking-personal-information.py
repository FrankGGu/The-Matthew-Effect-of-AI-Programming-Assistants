class Solution:
    def maskPII(self, s: str) -> str:
        if '@' in s:
            name, domain = s.split('@')
            return name[0].lower() + "*****" + name[-1].lower() + "@" + domain.lower()
        else:
            digits = [d for d in s if d.isdigit()]
            local = "".join(digits[-4:])
            country = "".join(digits[:-4])
            if len(country) > 0:
                country = "+" + "*" * len(country) + "-"
            return country + "***-***-" + local
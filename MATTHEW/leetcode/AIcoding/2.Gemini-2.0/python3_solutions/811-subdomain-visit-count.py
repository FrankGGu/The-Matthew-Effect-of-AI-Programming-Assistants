from collections import defaultdict

class Solution:
    def subdomainVisits(self, cpdomains: list[str]) -> list[str]:
        counts = defaultdict(int)
        for cpdomain in cpdomains:
            count, domain = cpdomain.split()
            count = int(count)
            parts = domain.split('.')
            for i in range(len(parts)):
                subdomain = '.'.join(parts[i:])
                counts[subdomain] += count

        result = []
        for domain, count in counts.items():
            result.append(str(count) + ' ' + domain)

        return result
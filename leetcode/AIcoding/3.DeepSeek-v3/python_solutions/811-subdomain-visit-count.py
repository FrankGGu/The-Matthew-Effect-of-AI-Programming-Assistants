class Solution:
    def subdomainVisits(self, cpdomains: List[str]) -> List[str]:
        domain_counts = {}
        for domain in cpdomains:
            count, full_domain = domain.split()
            count = int(count)
            subdomains = full_domain.split('.')
            for i in range(len(subdomains)):
                subdomain = '.'.join(subdomains[i:])
                domain_counts[subdomain] = domain_counts.get(subdomain, 0) + count
        return [f"{count} {domain}" for domain, count in domain_counts.items()]
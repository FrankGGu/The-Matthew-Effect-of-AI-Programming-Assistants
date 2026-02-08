from collections import defaultdict

def subdomainVisits(cpdomains):
    count = defaultdict(int)
    for domain in cpdomains:
        num, dom = domain.split()
        num = int(num)
        parts = dom.split('.')
        for i in range(len(parts)):
            count['.'.join(parts[i:])] += num
    return [f"{count} {domain}" for domain, count in count.items()]
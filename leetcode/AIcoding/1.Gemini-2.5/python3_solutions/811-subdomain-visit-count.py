from typing import List

class Solution:
    def subdomainVisits(self, cpdomains: List[str]) -> List[str]:
        counts = {}
        for cpdomain in cpdomains:
            parts = cpdomain.split(" ")
            count = int(parts[0])
            domain = parts[1]

            current_domain = domain
            while True:
                counts[current_domain] = counts.get(current_domain, 0) + count
                dot_index = current_domain.find(".")
                if dot_index == -1:
                    break
                current_domain = current_domain[dot_index + 1:]

        result = []
        for domain, count in counts.items():
            result.append(f"{count} {domain}")

        return result
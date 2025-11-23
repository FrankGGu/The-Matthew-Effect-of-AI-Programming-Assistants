class Solution:
    def adventureCamp(self, expeditions):
        max_new = -1
        res = -1
        known = set()
        initial = expeditions[0].split('->')
        for site in initial:
            known.add(site)

        for i in range(1, len(expeditions)):
            current = expeditions[i].split('->')
            new_sites = 0
            for site in current:
                if site and site not in known:
                    known.add(site)
                    new_sites += 1
            if new_sites > max_new and new_sites > 0:
                max_new = new_sites
                res = i
        return res
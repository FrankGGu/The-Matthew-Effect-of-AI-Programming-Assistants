class Solution:
    def getOrganizationInfo(self, employees: List[List[str]], id: str) -> List[str]:
        from collections import defaultdict

        tree = defaultdict(list)
        info = {}

        for eid, name, manager in employees:
            info[eid] = name
            if manager != "":
                tree[manager].append(eid)

        def dfs(eid):
            subordinates = tree[eid]
            res = [info[eid]]
            for sub in subordinates:
                res.extend(dfs(sub))
            return res

        return dfs(id)
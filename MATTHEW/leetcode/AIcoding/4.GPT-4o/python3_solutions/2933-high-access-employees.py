class Solution:
    def highAccessEmployees(self, employees: List[List[int]]) -> List[int]:
        from collections import defaultdict

        access_count = defaultdict(int)
        for emp in employees:
            for acc in emp[1:]:
                access_count[acc] += 1

        max_access = max(access_count.values())
        return [emp[0] for emp in employees if access_count[emp[0]] == max_access]
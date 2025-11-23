class Solution:
    def findHighAccessEmployees(self, access_times: List[List[str]]) -> List[str]:
        from collections import defaultdict

        employee_access = defaultdict(list)

        for employee, time in access_times:
            hours = int(time[:2])
            minutes = int(time[2:])
            total_minutes = hours * 60 + minutes
            employee_access[employee].append(total_minutes)

        result = []
        for employee in employee_access:
            times = sorted(employee_access[employee])
            n = len(times)
            for i in range(n - 2):
                if times[i + 2] - times[i] < 60:
                    result.append(employee)
                    break

        return result
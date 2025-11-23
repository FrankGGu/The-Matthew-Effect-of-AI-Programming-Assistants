from collections import defaultdict

class Solution:
    def findHighAccessEmployees(self, access_times: list[list[str]]) -> list[str]:
        employee_times = defaultdict(list)
        for employee, time in access_times:
            employee_times[employee].append(int(time))

        result = []
        for employee, times in employee_times.items():
            times.sort()
            for i in range(len(times) - 2):
                if times[i+2] - times[i] < 60:
                    result.append(employee)
                    break

        return result
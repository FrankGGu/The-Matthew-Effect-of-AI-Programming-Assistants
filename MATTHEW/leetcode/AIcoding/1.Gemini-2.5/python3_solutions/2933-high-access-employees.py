from collections import defaultdict

class Solution:
    def highAccessEmployees(self, accessTimes: list[list[str]]) -> list[str]:
        employee_accesses = defaultdict(list)

        for name, time_str in accessTimes:
            hours = int(time_str[:2])
            minutes = int(time_str[2:])
            total_minutes = hours * 60 + minutes
            employee_accesses[name].append(total_minutes)

        high_access_employees = set()

        for name, times in employee_accesses.items():
            times.sort()

            if len(times) < 3:
                continue

            for i in range(len(times) - 2):
                if times[i+2] - times[i] <= 59: # 1-hour period means 60 minutes, so difference must be less than 60
                    high_access_employees.add(name)
                    break

        return sorted(list(high_access_employees))